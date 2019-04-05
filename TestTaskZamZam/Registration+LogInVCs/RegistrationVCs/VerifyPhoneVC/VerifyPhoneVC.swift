//
//  VerifyPhoneVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 04/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import FlagKit
import PhoneNumberKit

class VerifyPhoneVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tfCountryCode: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var labEnterShortCode: myLabel!
    @IBOutlet weak var tfShortCode: UITextField!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    
    
    let twilioService = TwilioService.standard
    let codeVerified = TwilioService.standard.shortCodeVerified
    let maxCountryCodeLength = 3
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }

    func addObservers() {
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(setVisibleTFs),
                           name: NSNotification.Name(NotificationType.codeSent.rawValue),
                           object: nil)
        center.addObserver(self,
                           selector: #selector(verificationSucceed),
                           name: NSNotification.Name(NotificationType.codeVerified.rawValue),
                           object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCountryFlag()
    }
    
    func configureView() {
        
        viewBigWhite.layer.cornerRadius = 16
        tfShortCode.layer.cornerRadius = 8
        tfPhoneNumber.layer.cornerRadius = 8
        tfCountryCode.layer.cornerRadius = 8
        butNext.layer.cornerRadius = 8
        butNext.clipsToBounds = true
        setVisibleTFs()
        
    }
    
    func setCountryFlag() {
        let phoneNumberKit = PhoneNumberKit()
        
        guard let countryCode = UInt64(tfCountryCode!.text!) else {
            imCountry.image = UIImage()
            return
        }
        guard let country = phoneNumberKit.mainCountry(forCode: countryCode) else {
            imCountry.image = UIImage()
            return
        }
    
        let flagImage = Flag(countryCode: country)?.image(style: .circle)
        imCountry.image = flagImage
        tfPhoneNumber.becomeFirstResponder()
    }
    
    func checkPrefix(prefix: String,_ field: UITextField) {
        if (field.text != nil) && !field.text!.hasPrefix(prefix) {
            for char in prefix {
                if field.text!.hasPrefix(prefix) {
                    return
                }
                field.text!.insert(char, at: field.text!.startIndex)
            }
            
        }
    }
    
    func checkMaxCharacters(count: Int, field: UITextField) {
        if let text = field.text, text.count > count {
            field.text!.removeLast(text.count - count)
        }
    }
    
    
    @objc func setVisibleTFs() {
        switch twilioService.shortCodeSent {
        case true:
            UIView.animate(withDuration: 0.3) {
                self.labEnterShortCode.alpha = 1
                self.tfShortCode.alpha = 1
            }
            
        case false:
            UIView.animate(withDuration: 0.3) {
                self.labEnterShortCode.alpha = 0
                self.tfShortCode.alpha = 0
            }
        }
    }
    
    @objc func verificationSucceed() {
        
        let setNewPassVC = UIStoryboard(name: "Registration+LogIn",
                                        bundle: nil)
            .instantiateViewController(withIdentifier: "SetNewPassVC")
        self.navigationController?.show(setNewPassVC, sender: nil)
        
    }
    
    
    @IBAction func tFCountryCodeTextChanged(_ sender: UITextField) {
        setCountryFlag()
        checkPrefix(prefix: "+", sender)
        checkMaxCharacters(count: 1 + maxCountryCodeLength,
                           field: sender)
    }
    
    @IBAction func tFPhoneNumberTextChanged(_ sender: UITextField) {
        checkPrefix(prefix: "  ", sender)
    }
    
    
    @IBAction func tFShortCodeTextChanged(_ sender: UITextField) {
        if let code = sender.text, code.count == 6 {
            twilioService.checkShortCode(code: code)
        }
    }
    
    @IBAction func butBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        sender.setTitle("Отправить еще раз", for: .normal)
        
        let phone = tfCountryCode.text! + tfPhoneNumber.text!
        twilioService.sendShortCode(phone: phone)
    }
    
    
}
