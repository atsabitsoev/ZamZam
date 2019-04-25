//
//  PIN VC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 08/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import KeychainSwift
import LocalAuthentication

class PIN_VC: UIViewController {

    
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var labUser: myLabel!
    @IBOutlet weak var dotsView: DotsView!
    @IBOutlet weak var viewBigWhite: UIView!
    
    
    let keychain = KeychainSwift()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dotsView.totalDots = 4
        
        labUser.text = UserDefaults.standard.string(forKey: "userPhone")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(activateKeyboard))
        dotsView.addGestureRecognizer(gesture)
    }
    
    override func viewWillLayoutSubviews() {
        viewBigWhite.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let useTouchId = UserDefaults.standard.bool(forKey: "useTouchId")
        
        if useTouchId {
            touchFaceAuth()
        } else {
            tfPin.becomeFirstResponder()
        }
    }
    
    
    @objc func activateKeyboard() {
        print("hello")
        tfPin.becomeFirstResponder()
    }
    
    func touchFaceAuth() {
        
        print("hello there!.. You have clicked the touch ID")
        
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            self.enterToApp()
                        } else {
                            print("Неправильный палец или лицо")
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                print("Sorry!!.. Could not evaluate policy.")
            }
        } else {
            print("Не поддерживается")
            tfPin.becomeFirstResponder()
        }
        
    }
    
    func enterToApp() {
        
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTBController")
        self.present(home, animated: true, completion: nil)
        
    }
    
    func isPinRight(pin: String) -> Bool {
        
        let rightPin = keychain.get("PIN")
        if pin == rightPin {
            return true
        } else {
            return false
        }
        
    }
    
    func wrongPIN() {
        
        tfPin.backgroundColor = UIColor.red
        dotsView.color = #colorLiteral(red: 0.9176470588, green: 0.01960784314, blue: 0.231372549, alpha: 1)
        dotsView.solidDots = 0
        tfPin.text = ""
        
        
    }
    
    func showSureAlert() {
        let alert = UIAlertController(title: "Вы уверены?", message: "Вы хотите поменять аккаунт?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "ДА", style: .default) { (action) in
            self.logOut()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (alert) in}
        alert.addAction(actionYes)
        alert.addAction(actionCancel)
        self.show(alert, sender: nil)
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "userEntered")
        let regLogNavCon = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "RegLogNavCon")
        self.show(regLogNavCon, sender: nil)
    }
    
    
    @IBAction func tFPinTextChanged(_ sender: UITextField) {
        guard sender.text != nil else { return }
        
        dotsView.solidDots = sender.text!.count
        
        if sender.text?.count == 4 {
            let pin = sender.text!
            if isPinRight(pin: pin) {
                enterToApp()
            } else {
                wrongPIN()
            }
        }
        
        if var text = sender.text, text.count > 4 {
            text.removeLast()
        }
    
    }
    
    @IBAction func butLogOutTapped(_ sender: UIButton) {
        showSureAlert()
    }
    
    
    
}
