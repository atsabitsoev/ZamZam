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
    
    func configureView() {
        
        viewBigWhite.layer.cornerRadius = 16
        tfShortCode.layer.cornerRadius = 8
        tfPhoneNumber.layer.cornerRadius = 8
        tfCountryCode.layer.cornerRadius = 8
        butNext.layer.cornerRadius = butNext.bounds.height/2
        butNext.clipsToBounds = true
        setVisibleTFs()
        setCountryFlag()
        
    }
    
    func setCountryFlag() {
        
        guard let countryCode = UInt64(tfCountryCode!.text!) else { return }
        let phoneNumberKit = PhoneNumberKit()
        if let country = phoneNumberKit.mainCountry(forCode: countryCode) {
            let flagImage = Flag(countryCode: country)?.image(style: .circle)
            imCountry.image = flagImage
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
        
        print("verification succeed")
        
    }
    
    
    @IBAction func tFCountryCodeTextChanged(_ sender: UITextField) {
        
        let text = sender.text!
        let code = UInt64(text) ?? 0
        if PhoneNumberKit().mainCountry(forCode: code) != nil {
            print(PhoneNumberKit().countries(withCode: code)!)
            print("\n")
        } else {
            imCountry.image = UIImage()
        }
        
    }
    
    @IBAction func tFShortCodeTextChanged(_ sender: UITextField) {
    }
    
    @IBAction func butBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butNextTapped(_ sender: Any) {
        
        if twilioService.shortCodeSent {
            if let code = tfShortCode.text {
                twilioService.checkShortCode(code: code)
            }
        } else {
            twilioService.sendShortCode(phone: "+79777872475")
        }
    }
    
    
}
