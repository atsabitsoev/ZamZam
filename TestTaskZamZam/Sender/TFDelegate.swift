//
//  TFDelegate.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

//TODO: Продолжить тут!!!!!

extension SenderVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let section = textField.tag / 1000
        let row = textField.tag % 1000
        
        let cell = tableView.cellForRow(at: [section,row]) as! SenderCellField
        
        cell.viewWhite.animateBorderColor(toColor: #colorLiteral(red: 0.3370000124, green: 0.753000021, blue: 0.9919999838, alpha: 1), duration: 0.3)
        
        UIView.animate(withDuration: 0.3) {
            cell.labTitle.textColor =  _ColorLiteralType(red: 0.3370000124, green: 0.753000021, blue: 0.9919999838, alpha: 1)
            cell.labTitle.alpha = 1
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        dictUserData[textField.tag] = textField.text
        
        let section = textField.tag / 1000
        let row = textField.tag % 1000
        
        if let cell = tableView.cellForRow(at: [section,row]) as? SenderCellField {
            
            
            UIView.animate(withDuration: 0.3) {
                if textField.text != nil && textField.text != "" {
                    
                    cell.viewWhite.animateBorderColor(toColor: #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1), duration: 0.3)
                    
                    cell.labTitle.textColor = _ColorLiteralType(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
                    cell.labTitle.alpha = 1
                    
                } else {
                    
                    cell.labTitle.alpha = 0
                    cell.viewWhite.animateBorderColor(toColor: #colorLiteral(red: 0.7131326199, green: 0.7154058814, blue: 0.7812535763, alpha: 1), duration: 0.3)
                    
                }
                
            }
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}
