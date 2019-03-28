//
//  Currency.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

enum CurrencyType {
    
    case rubble
    case dollar
    
}

class CurrencyManager {
    private init() {}
    
    static func getCurrency(byType type: CurrencyType) -> CurrencyProtocol {
        switch type {
        case .rubble:
            return CurrencyRubble()
        case .dollar:
            return CurrencyDollar()
        }
    }
    
}

protocol CurrencyProtocol {
    
    var fullName: String { get }
    var shortName: String { get }
    var symbol: String { get }
    
}

struct CurrencyRubble: CurrencyProtocol {
    
    let fullName: String = "Rubble"
    let shortName: String = "RUB"
    let symbol: String = "₽"
    
}

struct CurrencyDollar: CurrencyProtocol {
    
    let fullName: String = "Dollar"
    let shortName: String = "USD"
    let symbol: String = "$"
    
}
