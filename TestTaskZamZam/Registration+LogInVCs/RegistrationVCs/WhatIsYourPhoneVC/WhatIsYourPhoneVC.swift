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
var setNewPasswordModeON = false

class WhatIsYourPhoneVC: UIViewController {
    
    
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var labPolicy: UILabel!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var tfPhoneNumber: PhoneNumberTextField!
    @IBOutlet weak var viewCheckRound: CheckRoundView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var currentCode = "+"
    let phoneVerificationService = PhoneVerificationService.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }

    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(goNext),
                                               name: NSNotification.Name(NotificationNames.codeSent.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userExists), name: NSNotification.Name(NotificationNames.userExists.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendingCodeFailed), name: NSNotification.Name(NotificationNames.sendingCodeError.rawValue), object: nil)
        
    }
    
    @objc private func userExists() {
        
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка", message: "Пользователь уже существует", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func sendingCodeFailed() {
        
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка", message: "Ошибка сервера", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func removeSendingCodeObservers() {
        
        NotificationCenter.default.removeObserver(self)
        
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
            return false
        }
        guard let country = phoneNumberKit.mainCountry(forCode: countryCode) else {
            return false
        }
        
        let flagImage = Flag(countryCode: country)?.image(style: .circle)
        imCountry.image = flagImage
        return true
    }

    
    func rememberPhone(_ phone: String) {
        temporaryPhone = "+\(phone.onlyNumbers())"
    }
    
    @objc func goNext() {
        
        print("Код отправлен")
        activityIndicator.stopAnimating()
        let verifyPhoneVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "verifyPhoneVC")
        self.navigationController?.show(verifyPhoneVC, sender: nil)
        removeSendingCodeObservers()
        
    }
    
    private func sendCode() {
        
        phoneVerificationService.verify(phone: temporaryPhone)
        activityIndicator.startAnimating()
        
    }
    
    private func sendCodeToResetPassword() {
        
        ResetPasswordService.standard.sendCode(to: temporaryPhone)
        activityIndicator.startAnimating()
        
    }
    
    
    @IBAction func tFPhoneNumberTextChanged(_ sender: UITextField) {
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
    
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        
        guard let phone = tfPhoneNumber.text else { return }
        rememberPhone(phone)
        
        if setNewPasswordModeON {
            
            addObservers()
            sendCodeToResetPassword()
            
        } else {
            
            addObservers()
            sendCode()
            
        }
        
    }
    
    
}
