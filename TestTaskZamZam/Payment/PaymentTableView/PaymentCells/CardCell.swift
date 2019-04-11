//
//  CardCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    @IBOutlet weak var labCardNumber: myLabel!
    @IBOutlet weak var viewUnderCheck: UIView!
    @IBOutlet weak var imCheck: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    
    
    override func layoutSubviews() {
        
        viewUnderCheck.clipsToBounds = true
        imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
        viewBackground.layer.cornerRadius = 8
        addBordersToViewUnderCheck()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            addCheck()
        } else {
            deleteCheck()
        }
        
    }
    
    
    func addCheck() {
        viewUnderCheck.alpha = 1
    }
    
    func deleteCheck() {
        viewUnderCheck.alpha = 0
    }
    
    func addBordersToViewUnderCheck() {
        viewUnderCheck.layer.borderWidth = 2
        viewUnderCheck.layer.borderColor = #colorLiteral(red: 0.5600509048, green: 0.92213732, blue: 0.528396666, alpha: 1)
    }
    
}
