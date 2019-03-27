//
//  WhatCountryTextField.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 14.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class WhatCountryTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0,
                               left: 36,
                               bottom: 0,
                               right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: padding)
       
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: padding)
        
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: padding)
        
    }
    
}
