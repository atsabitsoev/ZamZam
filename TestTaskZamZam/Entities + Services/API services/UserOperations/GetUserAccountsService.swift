//
//  GetUserAccountsService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 16/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetUserAccountsService {
    
    static let standard = GetUserAccountsService()
    private init() {}
    
    
    var zamBills: [ZamBill] = [] {
        didSet {
            post(notificationName: .zamBillsUpdated)
        }
    }
    var sumOfAllAccounts: Float = 0
    
    
    func sendGetZamBillsRequest() {
        
        print("Посылаю запрос ГЕТ с токеном - \(UserTokenService.standard.userAccessToken)")
        
        let  urlString = "http://10.80.80.99:2222/api/accounts"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserTokenService.standard.userAccessToken)"]
        let parameters: Parameters = [:]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseJSON { (response) in
                    
                    switch response.result {
                        
                    case .success:
                        
                        switch response.response?.statusCode {
                            
                        case 200:
                            
                            let json = JSON(response.result.value!)
                            
                            self.sumOfAllAccounts = json["summOfAllAccounts"].floatValue
                            
                            var zamBills: [ZamBill] = []
                            
                            let zamBillsInJson = json["accounts"].arrayValue
                            
                            for i in 0..<zamBillsInJson.count {
                                
                                let currencyShortName = zamBillsInJson[i]["currency"].stringValue.uppercased()
                                let currency = CurrencyManager.getCurrenct(byShortName: currencyShortName)
                                let sum = zamBillsInJson[i]["balance"].floatValue
                                
                                zamBills.append(ZamBill(currency: currency, sum: sum))
                            }
                            
                            self.zamBills = zamBills
                            
                            print(json)
                            
                        case 401:
                            
                            print("Устарел аксесс токен")
                            self.post(notificationName: .userAccessTokenIsOutOfDate)
                            print(response.result.value!)
                            
                        default:
                            
                            print(response.result.value!)
                            
                        }
                        
                    case .failure:
                        
                        print(response.result.error!)
                        
                    }
                    
        }
        
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
    
}
