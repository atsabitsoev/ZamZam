//
//  AddNewCardCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class AddNewCardCell: UITableViewCell {
    
    @IBOutlet weak var imPlus: UIImageView!
    @IBOutlet weak var viewUnderCheck: UIView!
    @IBOutlet weak var imCheck: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    
    
    override func layoutSubviews() {
        
        viewUnderCheck.clipsToBounds = true
        imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
        imPlus.image = imPlus.image?.withRenderingMode(.alwaysTemplate)
        addBordersToViewUnderCheck()
        configureViewBackground()
        
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
    
    func configureViewBackground() {
        viewBackground.layer.borderWidth = 2
        viewBackground.layer.borderColor = #colorLiteral(red: 0.1245268062, green: 0.1670093238, blue: 0.3904778957, alpha: 1)
        viewBackground.layer.cornerRadius = 8
    }
    
}
