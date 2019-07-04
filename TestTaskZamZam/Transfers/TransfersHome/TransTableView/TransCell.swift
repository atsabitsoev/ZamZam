//
//  TransCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 13.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TransCell: UITableViewCell {

    @IBOutlet weak var labTitle: myLabel!
    @IBOutlet weak var labDescribtion: myLabel!
    @IBOutlet weak var viewUnderPicture: UIView!
    @IBOutlet weak var imSmall: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMain.layer.cornerRadius = 8
        viewMain.layer.shadowColor = UIColor.black.cgColor// #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        viewMain.layer.shadowOpacity = 0.2
        viewMain.layer.shadowOffset = CGSize(width: 0,
                                             height: 3)
        viewMain.layer.shadowRadius = 4
        
        viewUnderPicture.layer.cornerRadius = 20
    }

}
