//
//  PaymentNewContactsDelegate.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import ContactsUI


extension PaymentNewVC: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        setNumber(of: contact)
    }
}
