//
//  TFService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 05/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TFService {
    
    static func checkPrefix(prefix: String,_ field: UITextField) {
        if (field.text != nil) && !field.text!.hasPrefix(prefix) {
            for char in prefix {
                if field.text!.hasPrefix(prefix) {
                    return
                }
                field.text!.insert(char, at: field.text!.startIndex)
            }
            
        }
    }
    
    static func checkMaxCharacters(count: Int, field: UITextField) {
        if let text = field.text, text.count > count {
            field.text!.removeLast(text.count - count)
        }
    }
    
}
