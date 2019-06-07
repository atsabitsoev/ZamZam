//
//  SenderCellPhoneNumber.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit
import FlagKit

class SenderCellPhoneNumber: UITableViewCell, UITextFieldDelegate {
    
    
    let phoneNumberKit = PhoneNumberKit()
    private var currentCode = "+" 
    
    
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
    
    
    func setCountryFlag(code: String) -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        
        guard let countryCode = UInt64(code) else {
            return false
        }
        guard let country = phoneNumberKit.mainCountry(forCode: countryCode) else {
            return false
        }
        
        let flagImage = Flag(countryCode: country)?.image(style: .circle)
        imCountry.image = flagImage
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.contentView.endEditing(true)
        return true
    }
    
    
    @IBAction func phoneChanged(_ sender: UITextField) {
        
        TFService.checkPrefix(prefix: "+", tfPhoneNumber)
        guard let text = sender.text else { return }
        if setCountryFlag(code: text) {
            currentCode = text
        } else {
            if text.count > currentCode.count && text.dropLast(text.count - currentCode.count) != currentCode {
                print(text.dropFirst(currentCode.count))
                print(currentCode)
                imCountry.image = UIImage()
            }
        }
    }
    
}
