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
    private lazy var clientId = keychain.get(TokenKeys.clientId.rawValue)
    private lazy var clientSecret = keychain.get(TokenKeys.clientSecret.rawValue)
    
    private var userPhone: String = ""
    
    private var codeIsHere = false

    private var appAccessToken = "" {
        didSet {
            saveToken()
            post(.appAccessTokenIsGot)
        }
    }
    
    
    func verify(phone: String) {
        
        codeIsHere = false
        self.getAppAccessToken()
        self.userPhone = phone
        observeToSendCode(.appAccessTokenIsGot)
        
    }
    
    
    private func getAppAccessToken() {
        
        let urlString = "http://10.80.80.99:2222/api/token"
        guard let url = URL(string: urlString) else { return }
        
        let parameters: Parameters = ["grant_type":"client_credentials",
                                      "client_id":clientId!,
                                      "client_secret":clientSecret!]
        
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
                
                print(response.result.error!)
                
            }
            
        }
        
    }

    
    @objc private func sendCode() {
        
        print("Сейчас отправлю код")
        observeIsCodeSent()
        
        let urlString = "http://10.80.80.99:2222/api/user/phonenumberverifycode"
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(appAccessToken)"]
        let parameters: Parameters = ["PhoneNumber": userPhone]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                self.post(.codeSent)
            case .failure:
                print(response.result.error!.localizedDescription)
            }
            
        }
        
    }
    
    
    @objc private func codeHasCome() {
        self.codeIsHere = true
        print("Код отправлен")
    }
    
    
    func checkVerification(code: String) {
        
        let urlString = "http://10.80.80.99:2222/api/user/verifyphonenumber"
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
    
    
    private func post(_ name: PhoneVerificationNotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(name.rawValue), object: nil)
    }
    
    private func observeToSendCode(_ name: PhoneVerificationNotificationNames) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendCode),
                                               name: NSNotification.Name(rawValue: name.rawValue),
                                               object: nil)
    }
    
    private func observeIsCodeSent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(codeHasCome),
                                               name: NSNotification.Name(PhoneVerificationNotificationNames.codeSent.rawValue),
                                               object: nil)
    }
    
    private func saveToken() {
        UserDefaults.standard.set(appAccessToken, forKey: TokenKeys.appAccessToken.rawValue)
    }
    
    
}
