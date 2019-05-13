//
//  RegistrationService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 07/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift

class RegistrationService {
    
    private init() {}
    static let standard = RegistrationService()
    
    
    private let keychain = KeychainSwift()
    private lazy var clientId = keychain.get(TokenKeys.clientId.rawValue)!
    private lazy var clientSecret = keychain.get(TokenKeys.clientSecret.rawValue)!
    
    
    func register(phone: String, password: String) {
        
        let urlString = "http://10.80.80.99:2222/api/user/register"
        guard let url = URL(string: urlString) else { return }
        
        let appAccessToken = UserDefaults.standard.string(forKey: TokenKeys.appAccessToken.rawValue) ?? ""
        
        let parameters: Parameters = ["Username":phone,
                                      "Password":password]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                if response.response?.statusCode == 200 {
                    
                    print("Регистрация прошла успешно")
                    self.post(.registrationSucceed)
                    
                } else {
                    
                    print(response.result.value!)
                    self.post(.userExists)
                    
                }
                
                print(response.result.value!)
                
            case .failure:
                self.post(.registrationFailed)
                print(response.result.error!.localizedDescription)
                
            }
            
        }
        
    }
    
    
    private func post(_ name: RegistrationNotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: nil)
    }
    
    
    
}
