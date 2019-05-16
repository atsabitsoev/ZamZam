//
//  ZamBill.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class ZamBill {
    
    var currencyType: CurrencyType
    var sum: Float
    
    init(currencyType: CurrencyType,
         sum: Float) {
        self.currencyType = currencyType
        self.sum = sum
    }
    
}
