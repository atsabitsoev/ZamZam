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

class RegistrationService {
    
    private init() {}
    static let standard = RegistrationService()
    
    
    func register(phone: String, password: String) {
        
        let urlString = "http://10.80.80.99:2222/api/user/register"
        guard let url = URL(string: urlString) else { return }
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        
        let parameters: Parameters = ["Username":phone,
                                      "Password":password]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                print("Регистрация прошла успешно")
                
            case .failure:
                
                print(response.result.error!.localizedDescription)
                
            }
            
        }
        
    }
    
}
