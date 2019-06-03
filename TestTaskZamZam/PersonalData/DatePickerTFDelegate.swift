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
        showDatePicker(textField as! MaterialTextField)
    }
    
}
