//
//  UserProfileService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 31/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class UserProfileService {
    
    
    private init() {}
    static let standard = UserProfileService()
    
    
    var userProfileInfo: UserProfileInfo?
    
    
    func getUserInfoRequest() {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/details"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserTokenService.standard.userAccessToken)",
                                    "Content-Type":"application/json"]
        
        AF.request(url, method: .get, parameters: nil, headers: headers, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                switch response.response?.statusCode {
                    
                case 200:
                    
                    let json = try! JSON(data: response.data!)
                    
                    self.userProfileInfo = self.parseProfileInfo(from: json)
                    self.post(notificationName: .userProfileGot)
                    
                case 401:
                    
                    print("Устарели токены")
                    self.post(notificationName: .userAccessTokenIsOutOfDate)
                    
                default:
                    
                    print(print(response.value!))
                    self.post(notificationName: .userProfileGettingFailed)
                    
                }
                
            case .failure:
                
                print(response.error!)
                self.post(notificationName: .userProfileGettingFailed)
                
            }
        }
    }
    
    
    func postUserInfoRequest(userProfileInfo: UserProfileInfo) {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/user/details"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserTokenService.standard.userAccessToken)"]
        
        let parameters: Parameters = ["lastName": userProfileInfo.lastName,
                                      "firstName": userProfileInfo.firstName,
                                      "middleName": userProfileInfo.middleName,
                                      "birthDate": userProfileInfo.birthDate,
                                      "countryCode": userProfileInfo.countryCode,
                                      "city": userProfileInfo.city,
                                      "address": userProfileInfo.address,
                                      "passportNumber": userProfileInfo.passportNumber,
                                      "passportIssueDate": userProfileInfo.passportIssueDate,
                                      "passportAuthority": userProfileInfo.passportAuthority]
        
         AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                switch response.response?.statusCode {
                    
                case 200:
                    
                    print(response.value!)
                    self.post(notificationName: .userProfilePostSucceed)
                    
                case 401:
                    
                    print(response.value!)
                    self.post(notificationName: .userAccessTokenIsOutOfDate)
                    
                default:
                    
                    print(response.value!)
                    self.post(notificationName: .userProfilePostFailed)
                    
                }
                
            case .failure:
                
                print(response.error!)
                self.post(notificationName: .userProfilePostFailed)
                
            }
            
        }
        
        
    }
    
    
    private func parseProfileInfo(from json: JSON) -> UserProfileInfo {
        
        let lastName = json["lastName"].stringValue
        let firstName = json["firstName"].stringValue
        let middleName = json["middleName"].stringValue
        let birthDate = json["birthDate"].stringValue
        let countryCode = json["countryCode"].stringValue
        let city = json["city"].stringValue
        let address = json["address"].stringValue
        let passportNumber = json["passportNumber"].stringValue
        let passportIssueDate = json["passportIssueDate"].stringValue
        let passportAuthority = json["passportAuthority"].stringValue
        
        let userProfileInfo = UserProfileInfo(lastName: lastName,
                                              firstName: firstName,
                                              middleName: middleName,
                                              birthDate: birthDate,
                                              countryCode: countryCode,
                                              city: city,
                                              address: address,
                                              passportNumber: passportNumber,
                                              passportIssueDate: passportIssueDate,
                                              passportAuthority: passportAuthority)
        
        return userProfileInfo
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
    
    
}
