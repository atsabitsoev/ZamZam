//
//  Extensions for String.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 05/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

extension String {
    
    func withoutSpaces() -> String {
        var string = self
        for char in string {
            if char == " " {
                string.remove(at: string.firstIndex(of: " ")!)
            }
        }
        return string
    }
    
    func countOfNumbers() -> Int {
        let string = self
        let numbers: [Character] = ["0","1","2","3","4","5","6","7","8","9"]
        var count = 0
        for char in string {
            if numbers.contains(char) {
                count += 1
            }
        }
        return count
    }
    
}
