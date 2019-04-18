//
//  Bill.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class CardBill {
    
    var name: String
    var sum: Float
    var first4Numbers: Int
    var last4numbers: Int
    var currency: CurrencyType
    
    init (name: String,
          sum: Float,
          first4Numbers: Int,
          last4numbers: Int,
          currency: CurrencyType) {
        self.name = name
        self.sum = sum
        self.first4Numbers = first4Numbers
        self.last4numbers = last4numbers
        self.currency = currency
    }
    
}
