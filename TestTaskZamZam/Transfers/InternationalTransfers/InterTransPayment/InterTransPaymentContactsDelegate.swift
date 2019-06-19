//
//  InterTransPaymentContactsDelegate.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import ContactsUI


extension InterTransPaymentVC: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        setNumber(of: contact)
    }
}
