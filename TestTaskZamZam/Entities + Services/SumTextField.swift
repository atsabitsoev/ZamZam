//
//  SumTextField.swift
//  TestTaskZamZam
//
//  Created by Iliya B on 02/07/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SumTextField: UITextField {

    override var text: String? {
        didSet {
            print("didSetText")
        }
    }

}

