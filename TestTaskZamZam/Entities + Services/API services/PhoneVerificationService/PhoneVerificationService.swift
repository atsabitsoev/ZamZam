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

class PhoneVerificationService {
    
    private init() {}
    static let standard = PhoneVerificationService()
    
    
    private let keychain = KeychainSwift()
    private let appTokenService = AppTokenService.standard
    
    private lazy var clientId = keychain.get(TokenKeys.clientId.rawValue)
    private lazy var clientSecret = keychain.get(TokenKeys.clientSecret.rawValue)
    private lazy var appAccessToken = appTokenService.appAccessToken
    
    private var userPhone: String = ""
    
    
    func verify(phone: String) {
        
        appTokenService.sendRequest(.appAccessToken)
        self.userPhone = phone
        observeToSendCode(.appAccessTokenIsGot)
        
    }

    
    @objc private func sendCode() {
        
        print("Сейчас отправлю код")
        observeIsCodeSent()
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/phonenumberverifycode"
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        let parameters: Parameters = ["PhoneNumber": userPhone]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                if response.response?.statusCode == 200 {
                    self.post(.codeSent)
                    print("Отправил код")
                } else {
                    self.post(.userExists)
                }
            case .failure:
                print(response.result.error!.localizedDescription)
                self.post(.sendingCodeError)
            }
            
        }
        
    }
    
    
    @objc private func codeHasCome() {
        print("Код отправлен")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func checkVerification(code: String) {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/verifyphonenumber"
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        let parameters: Parameters = ["PhoneNumber": userPhone,
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
    
    
    private func post(_ name: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: nil)
    }
    
    private func observeToSendCode(_ name: NotificationNames) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendCode),
                                               name: NSNotification.Name(rawValue: name.rawValue),
                                               object: nil)
    }
    
    private func observeIsCodeSent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(codeHasCome),
                                               name: NSNotification.Name(NotificationNames.codeSent.rawValue),
                                               object: nil)
    }
    
    private func saveToken() {
        UserDefaults.standard.set(appAccessToken, forKey: TokenKeys.appAccessToken.rawValue)
    }
    
    
}
