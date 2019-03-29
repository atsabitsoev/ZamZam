//
//  TotalInfoCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TotalInfoCell: UITableViewCell {
    
    @IBOutlet weak var labCurrencies: myLabel!
    @IBOutlet weak var Comission: myLabel!
    @IBOutlet weak var viewGreenUnderCashBack: UIView!
    @IBOutlet weak var labCashBack: myLabel!
    @IBOutlet weak var labSum: myLabel!
    
    
    override func layoutSubviews() {
        viewGreenUnderCashBack.layer.cornerRadius = 8
    }
    
}
