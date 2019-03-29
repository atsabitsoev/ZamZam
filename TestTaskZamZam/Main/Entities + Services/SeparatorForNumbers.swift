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
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        return formatter
    }()
    
}

extension Float {
    
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
}
