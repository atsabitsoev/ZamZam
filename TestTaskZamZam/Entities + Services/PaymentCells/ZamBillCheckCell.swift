//
//  BillCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ZamBillCheckCell: UITableViewCell {
    
    @IBOutlet weak var labName: myLabel!
    @IBOutlet weak var labSum: myLabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewValuta: UIView!
    @IBOutlet weak var labCurrency: myLabel!
    @IBOutlet weak var viewUnderCheck: UIView!
    @IBOutlet weak var imCheck: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViewMain()
        viewValuta.layer.cornerRadius = 18
    }
    
    override func layoutSubviews() {
        
        viewUnderCheck.clipsToBounds = true
        imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
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
    
    
    func configureViewMain() {
        let layer = viewMain.layer
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(white: 0.84, alpha: 1).cgColor
        layer.shadowRadius = 5
    }
    
}
