//
//  ReplenAddCardCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 09/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ReplenAddCardCell: UITableViewCell {
    
    
    @IBOutlet weak var imPlus: UIImageView!
    @IBOutlet weak var viewClear: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewClear.layer.cornerRadius = 8
        viewClear.layer.borderColor = #colorLiteral(red: 0.3297697008, green: 0.3307734132, blue: 0.3431242108, alpha: 1)
        viewClear.layer.borderWidth = 4
        
        imPlus.image = imPlus.image?.withRenderingMode(.alwaysTemplate)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
