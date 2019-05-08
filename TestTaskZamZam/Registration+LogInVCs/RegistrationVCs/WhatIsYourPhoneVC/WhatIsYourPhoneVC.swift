//
//  WhatIsYourPhoneVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 17/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit
import FlagKit

var temporaryPhone = ""
var temporaryPass = ""

class WhatIsYourPhoneVC: UIViewController {
    
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var labPolicy: UILabel!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var tfPhoneNumber: PhoneNumberTextField!
    @IBOutlet weak var viewCheckRound: CheckRoundView!
    
    var currentCode = "+"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }

    
    func configureView() {
        configureButNext()
        viewMain.layer.cornerRadius = 16
        viewPhoneNumber.layer.borderWidth = 2
        viewPhoneNumber.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        viewPhoneNumber.layer.cornerRadius = 8
        
        
        labPolicy.center = CGPoint(x: labPolicy.center.x, y: viewCheckRound.center.y)
    }
    
    func configureButNext() {
        print("Рамка кнопки некст: \(butNext.bounds)")
        butNext.layer.cornerRadius = 8
        butNext.addGradient(colors: [UIColor(red: 86/255,
                                             green: 192/255,
                                             blue: 253/255,
                                             alpha: 1).cgColor,
                                     UIColor(red: 40/255,
                                             green: 161/255,
                                             blue: 231/255,
                                             alpha: 1).cgColor],
                            coordinatesX: [0,0],
                            coordinatesY: [0,1],
                            cornerRadius: butNext.layer.cornerRadius)
        
        butNext.layer.shadowColor = #colorLiteral(red: 0.2509803922, green: 0.6980392157, blue: 0.9529411765, alpha: 1)
        butNext.layer.shadowOpacity = 0.64
        butNext.layer.shadowRadius = 10
        let bounds = butNext.bounds
        let insetedBounds = bounds.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: -10, right: 10))
        
        butNext.layer.shadowPath = CGPath(rect: insetedBounds, transform: nil)
    }
    
    func setCountryFlag(code: String) -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        
        guard let countryCode = UInt64(code) else {
            imCountry.image = UIImage()
            return false
        }
        guard let country = phoneNumberKit.mainCountry(forCode: countryCode) else {
            imCountry.image = UIImage()
            return false
        }
        
        let flagImage = Flag(countryCode: country)?.image(style: .circle)
        imCountry.image = flagImage
        return true
    }
    
    func rememberPhone(_ phone: String) {
        temporaryPhone = getOnlyNumbers(phone)
    }
    
    func getOnlyNumbers(_ string: String) -> String {
        var newString = ""
        for c in string {
            if "1234567890".contains(c) {
                newString.append(c)
            }
        }
        return newString
    }
    
    func goNext() {
        let verifyPhoneVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "verifyPhoneVC")
        self.navigationController?.show(verifyPhoneVC, sender: nil)
    }
    
    
    @IBAction func tFPhoneNumberTextChanged(_ sender: UITextField) {
        TFService.checkPrefix(prefix: "+", tfPhoneNumber)
        guard let text = sender.text else { return }
        if text.count <= currentCode.count + 1 {
            if setCountryFlag(code: text) {
                currentCode = text
            }
        }
    }
    
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        guard let phone = tfPhoneNumber.text else { return }
        rememberPhone(phone)
        goNext()
    }
    
    
}
