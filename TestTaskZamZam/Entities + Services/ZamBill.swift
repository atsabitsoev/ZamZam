//
//  ZamBill.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class ZamBill {
    
    var currency: CurrencyType
    var sum: Float
    
    init(currency: CurrencyType,
         sum: Float) {
        self.currency = currency
        self.sum = sum
    }
    
}
