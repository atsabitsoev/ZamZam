//
//  TokenService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 16/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
import SwiftyJSON


class AppTokenService {
    
    static let standard = AppTokenService()
    private init () {}
    
    private let keychain = KeychainSwift()
    private let userTokenService = UserTokenService.standard
    private lazy var clientId = userTokenService.clientId
    private lazy var clientSecret = userTokenService.clientSecret
    
    
    var appAccessToken: String {
        
        get {
            
            let savedAccessToken = UserDefaults.standard.string(forKey: TokenKeys.appAccessToken.rawValue)!
            return savedAccessToken
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: TokenKeys.appAccessToken.rawValue)
            post(notificationName: .appAccessTokenIsGot)
            
        }
    }
    
    
    private func getAppAccessToken() {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/token"
        guard let url = URL(string: urlString) else { return }
        
        let parameters: Parameters = ["grant_type":"client_credentials",
                                      "client_id":clientId,
                                      "client_secret":clientSecret]
        
        AF.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                do {
                    
                    let json = try JSON(data: response.data!)
                    let appAccessToken = json["access_token"].stringValue
                    print("appAccessToken - \(appAccessToken)")
                    self.appAccessToken = appAccessToken
                    
                } catch {
                    
                    print(error)
                    
                }
                
            case .failure:
                
                print(response.error!)
                
            }
            
        }
        
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
    
    
    func sendRequest(_ token: TokenKeys) {
        
        switch token {
        case .appAccessToken:
            getAppAccessToken()
        default:
            print("errorrr")
        }
        
    }
    
}
