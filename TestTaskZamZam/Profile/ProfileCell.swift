//
//  ProfileCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    
    @IBOutlet var labTitle: UILabel!
    @IBOutlet var imageMain: UIImageView!
    @IBOutlet var shadowView: ShadowView!


    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.shadowOffset = CGSize(width: 0, height: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
