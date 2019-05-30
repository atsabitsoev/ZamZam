//
//  Transaction.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation


class Transaction {
    
    
    var sum: Double
    var currency: CurrencyProtocol
    var direction: TransferDirection
    var recipientPhone: String
    var senderPhone: String
    var date: Date
    
    
    init(sum: Double,
         currency: CurrencyProtocol,
         direction: TransferDirection,
         recipientPhone: String,
         senderPhone: String,
         date: Date) {
        
        self.sum = sum
        self.currency = currency
        self.direction = direction
        self.recipientPhone = recipientPhone
        self.senderPhone = senderPhone
        self.date = date
    }
}
