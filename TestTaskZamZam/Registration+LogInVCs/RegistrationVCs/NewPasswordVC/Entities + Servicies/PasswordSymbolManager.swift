//
//  PasswordSymbolManager.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 25/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class PasswordSymbolManager {
    
    private static let whiteList: String = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890."
    private static let capitalLetters: String = "QWERTYUIOPASDFGHJKLZXCVBNM"
    
    static func checkSymbol(_ symbol: String) -> Bool {
        
        guard symbol.count != 0 else { return true }
        
        return whiteList.contains(Character(symbol))
    }
    
    static func containsBigLetter(_ string: String) -> Bool {
        
        for letter in string {
            if capitalLetters.contains(letter) {
                return true
            }
        }
        
        return false
    }
    
}
