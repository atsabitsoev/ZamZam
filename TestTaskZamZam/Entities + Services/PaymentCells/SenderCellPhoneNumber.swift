//
//  SenderCellPhoneNumber.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SenderCellPhoneNumber: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var imUser: UIImageView! {
        didSet {
            imUser.image = imUser.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var labTitle: myLabel!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var viewWhite: UIView! {
        didSet {
            viewWhite.layer.borderWidth = 2
            viewWhite.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
            viewWhite.layer.cornerRadius = 8
        }
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
