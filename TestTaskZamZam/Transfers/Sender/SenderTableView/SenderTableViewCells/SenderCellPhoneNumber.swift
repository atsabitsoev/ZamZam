//
//  SenderCellPhoneNumber.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SenderCellPhoneNumber: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var labTitle: myLabel!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var viewWhite: UIView!
    
    
    override func layoutSubviews() {
        imCountry.layer.cornerRadius = imCountry.bounds.width/2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tfPhoneNumber.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.contentView.endEditing(true)
        return true
    }

}
