//
//  UserTokenService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 16/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
import SwiftyJSON


class UserTokenService {
    
    static let standard = UserTokenService()
    private init() {}
    
    private let keychain = KeychainSwift()
    
    
    var clientId: String {
        get {
            return keychain.get(TokenKeys.clientId.rawValue)!
        }
        set {
            keychain.set(newValue, forKey: TokenKeys.clientId.rawValue)
        }
    }
    
    var clientSecret: String {
        get {
            return keychain.get(TokenKeys.clientSecret.rawValue)!
        }
        set {
            keychain.set(newValue, forKey: TokenKeys.clientSecret.rawValue)
        }
    }
    
    var userAccessToken: String {
        get {
            return keychain.get(TokenKeys.userAccessToken.rawValue)!
        }
        set {
            keychain.set(newValue, forKey: TokenKeys.userAccessToken.rawValue)
        }
    }
    
    var userRefreshToken: String {
        get {
            return keychain.get(TokenKeys.userRefreshToken.rawValue)!
        }
        set {
            keychain.set(newValue, forKey: TokenKeys.userRefreshToken.rawValue)
        }
    }
    
    
    private func sendUpdateTokensRequest() {
        
        let urlString = "http://10.80.80.99:2222/api/token"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let parameters: Parameters = ["client_id": clientId,
                                      "client_secret": clientSecret,
                                      "grant_type": "refresh_token",
                                      "refresh_token": userRefreshToken]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: headers).responseJSON { (response) in
                    
                    switch response.result {
                        
                    case .success:
                        
                        switch response.response?.statusCode {
                            
                        case 200:
                            
                            let accessToken = JSON(response.result.value!)["access_token"].stringValue
                            let refreshToken = JSON(response.result.value!)["refresh_token"].stringValue
                            
                            self.userAccessToken = accessToken
                            self.userRefreshToken = refreshToken
                            
                           self.post(notificationName: .enterSucceed)
                            
                            print("access - \(accessToken)")
                            print("refresh - \(refreshToken)")
                            
                        default:
                            
                            self.post(notificationName: .enterFailed)
                            
                            print(response.result.value!)
                            
                        }
                        
                        
                    case .failure:
                        
                        self.post(notificationName: .enterFailed)
                        
                        print(response.result.error!)
                        
                    }
                    
        }
        
    }
    
    func updateTokens() {
        sendUpdateTokensRequest()
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
    
}
