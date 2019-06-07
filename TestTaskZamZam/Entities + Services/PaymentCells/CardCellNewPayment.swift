//
//  CardCellNewPayment.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 07/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class CardCellNewPayment: UITableViewCell {
    
    
    
    @IBOutlet weak var viewUnderCheck: UIView!
    @IBOutlet weak var imCheck: UIImageView! {
        didSet {
            imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    
    func addCheck() {
        print("\(viewUnderCheck.alpha)")
        viewUnderCheck.alpha = 1
    }
    
    func deleteCheck() {
        viewUnderCheck.alpha = 0
    }

}
