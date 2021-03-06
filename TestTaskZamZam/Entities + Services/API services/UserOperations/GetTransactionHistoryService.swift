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
    
    
    var masSortedTransactions: [[Transaction]]?
    var masTransactions: [Transaction] = []
    var pagesCount: Int = 1
    
    
    func fetchHistory(page: Int) {
        
        let urlString = "http://test.setclapp.com/zamzamapi/api/accounts/transactionhistory/\(page)"
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
                        
                        let pagesCount = json["pagesCount"].intValue
                        self.pagesCount = pagesCount
                        let transactions = self.convertToTransactions(json)
                        self.masTransactions = page == 0 ? transactions : self.masTransactions + transactions
                        self.masSortedTransactions = self.sortByDate(self.masTransactions)
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
                print(response.error!)
                
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
            let date = Date(timeIntervalSince1970: jsonTransaction["createdDate"].doubleValue)
            
            let transaction = Transaction(sum: sum, currency: currency, direction: direction, recipientPhone: recipientPhone, senderPhone: senderPhone, date: date)
            print("transactionAdded with date: \(transaction.date)")
            
            transactions.append(transaction)
        }
        
        return transactions
    }
    
    private func sortByDate(_ transactions: [Transaction]) -> [[Transaction]]? {
        
        var masSortedTransacitons: [[Transaction]] = []
        var masDayTransactions: [Transaction] = []
        var currentDateComponents: DateComponents?
        var i = 0
        
        for trans in transactions {
            
            i += 1
            let calendar = Calendar.current
            let transComponents = calendar.dateComponents([.day, .month, .year], from: trans.date)
            
            if currentDateComponents == nil {
                
                masDayTransactions.append(trans)
                currentDateComponents = transComponents
                
                if i == transactions.count {
                    masSortedTransacitons.append(masDayTransactions)
                }
                
            } else if currentDateComponents == transComponents {
                
                masDayTransactions.append(trans)
                
                if i == transactions.count {
                    
                    masSortedTransacitons.append(masDayTransactions)
                }
                
            } else if currentDateComponents != transComponents {
                
                masSortedTransacitons.append(masDayTransactions)
                masDayTransactions = []
                masDayTransactions.append(trans)
                currentDateComponents = transComponents
                
            } else {
                return nil
            }
            
        }
        
        return masSortedTransacitons
    }
    
    
    private func post(notificationName: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(notificationName.rawValue), object: nil)
    }
    
    
}
