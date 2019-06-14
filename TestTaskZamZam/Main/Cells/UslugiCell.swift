//
//  UslugiCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 14/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class UslugiCell: UITableViewCell {

    
    @IBOutlet weak var viewWhite0: UIView!
    @IBOutlet weak var viewWhite1: UIView!
    
    
    override func awakeFromNib() {
        
        setShadow(view: viewWhite0)
        setShadow(view: viewWhite1)
    }
    
    
    func setShadow(view: UIView) {
        let layer = view.layer
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(white: 0.84, alpha: 1).cgColor
        layer.shadowRadius = 5
    }

}
