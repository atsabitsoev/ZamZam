//
//  BillCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class BillCell: UITableViewCell {
    
    
    @IBOutlet weak var labName: myLabel!
    @IBOutlet weak var labSum: myLabel!
    @IBOutlet weak var imChain: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewValuta: UIView!
    @IBOutlet weak var labValuta: myLabel!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var labCard: myLabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMain.layer.cornerRadius = 8
        
        viewMain.layer.cornerRadius = 8
        viewMain.layer.shadowOffset = CGSize(width: 0, height: 10)
        viewMain.layer.shadowOpacity = 0.65
        viewMain.layer.shadowColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
        viewMain.layer.shadowRadius = 10
        
        viewValuta.layer.cornerRadius = 18
        viewCard.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
