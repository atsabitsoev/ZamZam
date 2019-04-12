//
//  WhatCountryCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 14.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class WhatCountryCell: UITableViewCell {

    
    @IBOutlet weak var labNameOfCountry: myLabel!
    @IBOutlet weak var imageOfCountry: UIImageView!
    
    
    override func layoutSubviews() {
        imageOfCountry.layer.cornerRadius = imageOfCountry.bounds.width/2
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
