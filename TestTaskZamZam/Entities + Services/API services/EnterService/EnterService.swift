//
//  EnterService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 08/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
import SwiftyJSON

class EnterServise {
    
    private init() {}
    static let standard = EnterServise()
    
    
    let keychain = KeychainSwift()
    let userTokenService = UserTokenService.standard
    
    
    func enter(phone: String, password: String) {
        
        getUserTokens(phone: phone, password: password)
        
    }
    
    private func getUserTokens(phone: String, password: String) {
        
        let urlString = "http://10.80.80.99:2222/api/token"
        let url = URL(string: urlString)!
        
        let clientId = keychain.get(TokenKeys.clientId.rawValue)!
        let clientSecret = keychain.get(TokenKeys.clientSecret.rawValue)!
        
        let parameters: Parameters = ["grant_type":"password",
                                      "username": phone,
                                      "password": password,
                                      "client_id": clientId,
                                      "client_secret": clientSecret]
        
        AF.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                do {
                    
                    let json = try JSON(data: response.data!)
                    
                    if response.response?.statusCode == 200 {
                        
                        let accessToken = json["access_token"].stringValue
                        let refreshToken = json["refresh_token"].stringValue
                        
                        print("Вход прошел успешно")
                        
                        self.userTokenService.userAccessToken = accessToken
                        self.userTokenService.userRefreshToken = refreshToken
                        
                        self.post(.enterSucceed)
                        
                    } else if response.response?.statusCode == 400 {
                        
                        self.post(.wrongCredentials)
                        
                    } else {
                        
                        self.post(.enterFailed)
                        
                    }
                    
                } catch {
                    
                    print(error)
                    self.post(.enterFailed)
                    
                }
                
            case .failure:
                
                print(response.result.error!.localizedDescription)
                self.post(.enterFailed)
                
            }
            
        }
        
    }
    
    
    private func post(_ name: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: nil)
    }

}
