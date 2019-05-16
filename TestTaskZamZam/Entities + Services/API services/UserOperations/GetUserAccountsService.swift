//
//  GetUserAccountsService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 16/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire

class GetUserAccountsService {
    
    static let standard = GetUserAccountsService()
    private init() {}
    
    
    
    
    
    private func sendGetRequest() {
        
        let  urlString = "http://10.80.80.99:2222/api/accounts"
        let url = URL(string: urlString)
        
        let parameters: Parameters = ["":""]
        
        
    }
    
}
