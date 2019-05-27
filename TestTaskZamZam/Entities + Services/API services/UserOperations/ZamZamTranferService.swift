//
//  ZamZamTranferService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 17/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire


class ZamZamTransferService {
    
    
    private let userAccessToken = UserTokenService.standard.userAccessToken
    
    
    func sendMoney(to phone: String, sum: Float, senderCurrency: String, recipientCurrency: String) {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/funds/zamzamtransfer"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(userAccessToken)"]
        
        let parameters: Parameters = ["recipientPhoneNumber" : phone,
                                      "amount" : sum,
                                      "recipientCurrency" : recipientCurrency,
                                      "senderCurrency" : senderCurrency]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   headers: headers).responseJSON { (response) in
                    
                    switch response.result {
                        
                    case .success:
                        
                        switch response.response?.statusCode {
                            
                        case 200:
                            
                            self.post(notificationName: .zamZamTransferSucceed)
                            
                        case 401:
                            
                            self.post(notificationName: .userAccessTokenIsOutOfDate)
                            
                        default:
                            
                            self.post(notificationName: .zamZamTransferFailed)
                            
                        }
                        
                        print("json - \(response.result.value!)")
                        
                    case .failure:
                        
                        print(response.result.error!)
                        self.post(notificationName: .zamZamTransferFailed)
                        
                    }
        }
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
}
