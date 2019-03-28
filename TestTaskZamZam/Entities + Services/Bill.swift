//
//  Bill.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class Bill {
    
    var name: String
    var sum: Float
    var last4numbers: Int
    var currency: CurrencyType
    
    init (name: String,
          sum: Float,
          last4numbers: Int,
          currency: CurrencyType) {
        self.name = name
        self.sum = sum
        self.last4numbers = last4numbers
        self.currency = currency
    }
    
}
