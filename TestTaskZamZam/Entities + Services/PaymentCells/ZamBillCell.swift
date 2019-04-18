//
//  ZamBillCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ZamBillCell: UITableViewCell {

    @IBOutlet weak var labBillKind: myLabel!
    @IBOutlet weak var labBillSum: myLabel!
    @IBOutlet weak var viewUnderCheck: UIView!
    @IBOutlet weak var imCheck: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    
    var gradientAdded: Bool?
    
    override func layoutSubviews() {
        
        viewUnderCheck.clipsToBounds = true
        imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
        viewBackground.layer.cornerRadius = 8
        addGreenBordersToViewUnderCheck()
        
        viewBackground.layoutIfNeeded()
        viewBackground.addGradient(colors: [#colorLiteral(red: 0.1529411765, green: 0.631372549, blue: 0.9058823529, alpha: 1).cgColor, #colorLiteral(red: 0.337254902, green: 0.7529411765, blue: 0.9921568627, alpha: 1).cgColor], coordinatesX: [0,1], coordinatesY: [0,0], cornerRadius: 8)
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
    
    func addGreenBordersToViewUnderCheck() {
        viewUnderCheck.layer.borderColor = #colorLiteral(red: 0.5607843137, green: 0.9215686275, blue: 0.5294117647, alpha: 1)
        viewUnderCheck.layer.borderWidth = 2
    }

}
