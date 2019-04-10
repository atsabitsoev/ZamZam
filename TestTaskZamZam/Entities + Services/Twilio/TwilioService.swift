//
//  TwilioService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 04/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TwilioService {
    
    static let standard = TwilioService()
    private init() {}
    
    
    var shortCodeSent = false {
        didSet {
            if shortCodeSent {
                self.postNotification(.codeSent)
            }
        }
    }
    
    var shortCodeVerified = false {
        didSet {
            if shortCodeVerified {
                self.postNotification(.codeVerified)
            }
        }
    }
    
    private var shortCodeSid: String?
    private var usersPhone: String?
    
    
    func sendShortCode(phone: String) {
        
        let parameters = ["To": phone,
                          "Channel":"sms"]
        
        AF.request("https://verify.twilio.com/v2/Services/VA8fda58f11cf0219445fbc21a418b4453/Verifications",
                   method: .post,
                   parameters: parameters,
                   headers: [:])
            .authenticate(username: "AC7284e1760897943713163c817d6bc5bb", password: "f7c3c685ce75cb4cc69c0bd7f0472ee0")
            .responseJSON { (response) in
                
                switch response.result {
                case .success:
                    let data = response.data
                    do {
                        let json = try JSON(data: data!)
                        print(json)
                        let status = json["status"]
                        if status == "pending" {
                            let sid = json["sid"].stringValue
                            self.shortCodeSid = sid
                            self.usersPhone = phone
                            self.shortCodeSent = true
                        }

                    } catch {
                        print(error)
                        self.shortCodeSent = false
                    }
                case .failure:
                    print(response.result.error!.localizedDescription)
                }
        }
        
        
    }
    
    func checkShortCode(code: String) {
        guard usersPhone != nil else { return }
        
        if shortCodeSent && shortCodeSid != nil {
            let parameters = ["To": usersPhone,
                              "Sid": shortCodeSid,
                              "Code": code]
            
            AF.request("https://verify.twilio.com/v2/Services/VA8fda58f11cf0219445fbc21a418b4453/VerificationCheck",
                       method: .post,
                       parameters: parameters,
                       headers: [:])
                .responseJSON { (response) in
                    
                    switch response.result {
                    case .success:
                        let data = response.data
                        do {
                            let json = try JSON(data: data!)
                            if json["valid"].boolValue {
                                self.shortCodeVerified = true
                                
                            } else {
                                self.shortCodeVerified = false
                            }
                            print(json)
                            
                        } catch {
                            self.shortCodeVerified = false
                            print(error)
                        }
                    case .failure:
                        print(response.result.error!.localizedDescription)
                    }
            }
        }
    }
    
    
    private func postNotification(_ type: NotificationType) {
        let center = NotificationCenter.default
        center.post(name: NSNotification.Name(type.rawValue), object: nil)
    }
    
}
