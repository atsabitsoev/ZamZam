//
//  SeparatorForNumbers.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 07/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

extension Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.currencySymbol = ""
        formatter.decimalSeparator = ","
        return formatter
    }()
    
}

extension Double {
    
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
}
