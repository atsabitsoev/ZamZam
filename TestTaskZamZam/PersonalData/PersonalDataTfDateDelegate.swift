//
//  DatePickerTFDelegate.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 03/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


extension PersonalDataVC: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            showDatePicker(textField as! MaterialTextField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
