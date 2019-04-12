//
//  TransDescribtionCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 14.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TransDescribtionCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var heightConstr: NSLayoutConstraint! {
        didSet {
            if UIScreen.main.bounds.width <= 375 {
                heightConstr.constant = 100
                self.layoutSubviews()
            }
        }
    }

}
