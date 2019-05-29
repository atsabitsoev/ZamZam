//
//  GetTransactionHistoryService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetTransactionHistoryService {
    
    private init() {}
    static let standard = GetTransactionHistoryService()
    
    
    var masTransactions: [Transaction]?
    
    
    func fetchHistory() {
        
        let urlString = "http://10.80.80.99:2222/api/accounts/transactionhistory"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserTokenService.standard.userAccessToken)",
                                    "Content-Type":"application/json"]
        
        AF.request(url, method: .get, parameters: nil, headers: headers, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                do {
                    
                    let json = try JSON(data: response.data!)
                    
                    switch response.response?.statusCode {
                        
                    case 200:
                        
                        self.masTransactions = self.convertToTransactions(json)
                        self.post(notificationName: .historyGot)
                        
                    case 401:
                        
                        self.post(notificationName: .userAccessTokenIsOutOfDate)
                        
                    default:
                        
                        self.post(notificationName: .historyGetFailed)
                        print("error")
                    }
                    
                    self.post(notificationName: .historyGot)
                    print(json)
                    
                } catch {
                    
                    self.post(notificationName: .historyGetFailed)
                    print(error)
                }
                
            case .failure:
                
                self.post(notificationName: .historyGetFailed)
                print(response.result.error!)
                
            }
        }
    }
    
    
    private func convertToTransactions(_ json: JSON) -> [Transaction] {
        
        var transactions: [Transaction] = []
        
        let jsonTransactions = json["transactionsHistory"].arrayValue
        
        for jsonTransaction in jsonTransactions {
            
            let sum = jsonTransaction["amount"].doubleValue
            let currencyShortName = jsonTransaction["currency"].stringValue
            let currency = CurrencyManager.getCurrency(byShortName: currencyShortName)
            let direction: TransferDirection = jsonTransaction["cashFlow"].stringValue == "Outgoing" ? .out : .into
            let recipientPhone = jsonTransaction["recipientPhoneNumber"].stringValue
            let senderPhone = jsonTransaction["senderPhoneNumber"].stringValue
            
            let transaction = Transaction(sum: sum, currency: currency, direction: direction, recipientPhone: recipientPhone, senderPhone: senderPhone)
            
            transactions.append(transaction)
        }
        
        return transactions
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
    
    
}
