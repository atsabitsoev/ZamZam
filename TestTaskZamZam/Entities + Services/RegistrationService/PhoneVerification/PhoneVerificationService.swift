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

class PhoneVerificationService {
    
    static let standard = PhoneVerificationService()
    private init() {}
    
    
    private let clientId = "6ad65fbb-966d-4c41-8ff0-c3262011846d"
    private let clientSecret = "1e568a61-e3e8-45a3-8e80-f099c38d3711"
    
    private var userPhone: String = ""
    
    private var codeSent = false

    private var accessToken = "" {
        didSet {
            saveToken()
            post(.accessTokenIsGot)
        }
    }
    
    
    func verify(phone: String) {
        
        codeSent = false
        self.getAccessToken()
        self.userPhone = phone
        observeToSendCode(.accessTokenIsGot)
        
    }
    
    
    private func getAccessToken() {
        
        let urlString = "http://10.80.80.99:2222/api/token"
        guard let url = URL(string: urlString) else { return }
        
        let parameters: Parameters = ["grant_type":"client_credentials",
                                      "client_id":clientId,
                                      "client_secret":clientSecret]
        
        AF.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                do {
                    
                    let json = try JSON(data: response.data!)
                    let accessToken = json["access_token"].stringValue
                    print("accessToken - \(accessToken)")
                    self.accessToken = accessToken
                    
                } catch {
                    
                    print(error)
                    
                }
                
            case .failure:
                
                print(response.result.error!)
                
            }
            
        }
        
    }

    
    @objc private func sendCode() {
        
        observeIsCodeSent()
        
        let urlString = "http://10.80.80.99:2222/api/user/phonenumberverifycode"
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
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
    
    
    @objc private func codeIsSent() {
        self.codeSent = true
        print("Код отправлен")
    }
    
    
    func checkVerification(code: String) {
        
        let urlString = "http://10.80.80.99:2222/api/user/verifyphonenumber"
        guard let url = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
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
                                               selector: #selector(codeIsSent),
                                               name: NSNotification.Name(PhoneVerificationNotificationNames.codeSent.rawValue),
                                               object: nil)
    }
    
    private func saveToken() {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
    }
    
    
    
    
    
}
