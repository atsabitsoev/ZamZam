//
//  ResetPasswordService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift


class ResetPasswordService {
    
    static let standard = ResetPasswordService()
    private init() {}
    
    private let keychain = KeychainSwift()
    private let appTokenService = AppTokenService.standard
    
    
    private lazy var clientId = keychain.get(TokenKeys.clientId.rawValue)
    private lazy var clientSecret = keychain.get(TokenKeys.clientSecret.rawValue)
    private lazy var appAccessToken = appTokenService.appAccessToken
    
    
    private var currentPhone = ""
    private var userUid: String {
        get {
            return UserDefaults.standard.string(forKey: TokenKeys.userUid.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TokenKeys.userUid.rawValue)
        }
    }
    
    
    func sendCode(to phone: String) {
        
        currentPhone = phone
        addObserverToSendCode()
        appTokenService.sendRequest(.appAccessToken)
        
    }
    
    func checkVerification(code: String) {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/verify"
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        let parameters: Parameters = ["UserUid": userUid,
                                      "VerifyCode":code]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                if response.response?.statusCode == 200 {
                    print("Код оказался правильный")
                    self.post(.verificationSucceed)
                } else {
                    print("Ошибка")
                    print(response.result.value!)
                    self.post(.verificationFailed)
                }
                
            case .failure:
                
                print(response.result.error!.localizedDescription)
                self.post(.verificationFailed)
                
            }
            
        }
        
    }
    
    func setNewPassword(_ password: String) {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/resetPassword"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        
        let parameters: Parameters = ["UserUid": userUid,
                                      "Password": password]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).response { (response) in
            
            switch response.result {
                
            case .success:
                
                if response.response?.statusCode == 200 {
                    self.post(.passwordChanged)
                } else {
                    print(response.result.value!)
                    self.post(.passwordNotChanged)
                }
                
            case .failure:
                
                print(response.result.error!.localizedDescription)
                self.post(.passwordNotChanged)
                
            }
            
        }
        
    }
    
    private func addObserverToSendCode() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendRequestToSendCode), name: NSNotification.Name(NotificationNames.appAccessTokenIsGot.rawValue), object: nil)
        
    }
    
    @objc private func sendRequestToSendCode() {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/checkphonenumber"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        
        let parameters: Parameters = ["UserPhoneNumber": "\(currentPhone)"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let uid = response.result.value! as! String
                print()
                print(uid)
                print()
                self.userUid = uid
                self.post(.codeSent)
                
            case .failure:
                
                print(response.result.error!.localizedDescription)
                
            }
            
        }
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationNames.appAccessTokenIsGot.rawValue), object: nil)
        
    }
    
    
    private func post(_ notificationType: NotificationNames) {
        
        NotificationCenter.default.post(name: NSNotification.Name(notificationType.rawValue), object: nil)
        
    }
    
}
