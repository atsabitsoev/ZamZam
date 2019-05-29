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
    
    
    func getHistory() {
        
        let urlString = "http://10.80.80.99:2222/api/accounts/transactionhistory"
        let url = URL(string: urlString)!
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserTokenService.standard.userAccessToken)",
                                    "Content-Type":"application/json"]
        
        AF.request(url, method: .get, parameters: nil, headers: headers, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                do {
                    
                    let json = try JSON(data: response.data!)
                    print(json)
                    
                } catch {
                    print(error)
                }
                
            case .failure:
                
                print(response.result.error!)
                
            }
        }
    }
    
    
}
