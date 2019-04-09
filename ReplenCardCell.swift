
//
//  ReplenCardCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 09/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ReplenCardCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var imView: UIImageView!
    @IBOutlet weak var labCardNumber: myLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBlue.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
