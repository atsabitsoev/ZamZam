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


class UserTokenService {
    
    static let standard = UserTokenService()
    private init() {}
    
    let keychain = KeychainSwift()
    
    
    lazy var clientId = keychain.get(TokenKeys.clientId.rawValue)!
    lazy var clientSecret = keychain.get(TokenKeys.clientSecret.rawValue)!
    lazy var refreshToken = keychain.get(TokenKeys.userRefreshToken.rawValue)!
    
    
    private func sendUpdateTokensRequest() {
        
        let urlString = "http://10.80.80.99:2222/api/token"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = []
        
        let parameters: Parameters = ["client_id": clientId,
                                      "client_secret": clientSecret,
                                      "grant_type": "refresh_token",
                                      "refresh_token": refreshToken]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: headers).responseJSON { (response) in
                    
                    switch response.result {
                        
                    case .success:
                        
                        print(response.result.value!)
                        
                    case .failure:
                        
                        print(response.result.error!)
                        
                    }
                    
        }
        
    }
    
}
