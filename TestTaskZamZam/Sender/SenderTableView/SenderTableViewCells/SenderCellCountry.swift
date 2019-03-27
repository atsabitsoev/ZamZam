//
//  SenderCellCountry.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SenderCellCountry: UITableViewCell {

    
    
    @IBOutlet weak var viewWhite: UIView!
    @IBOutlet weak var labCountry: myLabel!
    @IBOutlet weak var labTitle: myLabel!
    @IBOutlet weak var imChevron: UIImageView!
    
    
    override func layoutSubviews() {
        imChevron.image = imChevron.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
