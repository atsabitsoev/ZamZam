//
//  SetNewPINVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 25/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import KeychainSwift

class SetNewPINVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tfNewPin: UITextField!
    @IBOutlet weak var tfRepeatPin: UITextField!
    @IBOutlet weak var dotsViewNewPin: DotsView!
    @IBOutlet weak var dotsViewRepeatPin: DotsView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tfNewPin.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        viewBigWhite.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tfNewPin.becomeFirstResponder()
    }
    
    
    func savePin(_ pin: String) {
        let keychain = KeychainSwift()
        keychain.set(pin, forKey: "PIN")
    }
    
    func savePhoneAndPassword() {
        let keychain = KeychainSwift()
        keychain.set(temporaryPass, forKey: temporaryPhone)
        rememberUser(phone: temporaryPhone)
    }
    
    func goNext() {
        let touchFaceVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "TouchFaceVC")
        self.navigationController?.show(touchFaceVC, sender: nil)
    }
    
    func rememberUser(phone: String) {
        UserDefaults.standard.set(true, forKey: "userEntered")
        UserDefaults.standard.setValue(phone, forKey: "userPhone")
    }
    
    
    @IBAction func tfNewPinTextChanged(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        
        if text.count <= dotsViewNewPin.totalDots {
            dotsViewNewPin.solidDots = text.count
        }
        
        if text.count == dotsViewNewPin.totalDots {
            dotsViewNewPin.color = #colorLiteral(red: 0.5098039216, green: 0.9254901961, blue: 0.462745098, alpha: 1)
            tfRepeatPin.becomeFirstResponder()
        } else {
            dotsViewNewPin.color = #colorLiteral(red: 0.1074947491, green: 0.1614276171, blue: 0.4236208797, alpha: 1)
        }
        print(sender.text)
    }
    
    @IBAction func tfRepeatPinTextChanged(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        if text == "" {
            tfNewPin.becomeFirstResponder()
        }
        
        if text.count <= dotsViewRepeatPin.totalDots {
            dotsViewRepeatPin.solidDots = text.count
        }
        
        if text.count == dotsViewRepeatPin.totalDots {
            if text == tfNewPin.text {
                dotsViewRepeatPin.color = #colorLiteral(red: 0.5098039216, green: 0.9254901961, blue: 0.462745098, alpha: 1)
                savePin(text)
                savePhoneAndPassword()
                goNext()
            } else {
                dotsViewRepeatPin.color = #colorLiteral(red: 0.9176470588, green: 0.01960784314, blue: 0.231372549, alpha: 1)
            }
        } else {
            dotsViewRepeatPin.color = #colorLiteral(red: 0.1074947491, green: 0.1614276171, blue: 0.4236208797, alpha: 1)
        }
        print(sender.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 4 && string != ""{
            tfRepeatPin.text?.append(string)
            dotsViewRepeatPin.solidDots += 1
            tfRepeatPin.becomeFirstResponder()
            return false
        }
        return true
    }
    
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
