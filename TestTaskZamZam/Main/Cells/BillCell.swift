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
        
        configureViewMain()
        viewValuta.layer.cornerRadius = 18
        viewCard.layer.cornerRadius = 5
    }
    
    
    func configureViewMain() {
        let layer = viewMain.layer
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.65
        layer.shadowColor = UIColor(white: 0.84, alpha: 1).cgColor
        layer.shadowRadius = 10
    }

}
