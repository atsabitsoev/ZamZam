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
    
    
    let keychain = KeychainSwift()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        touchFaceAuth()
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
    
    }
    
    
    @IBAction func tFPinTextChanged(_ sender: UITextField) {
        print("do")
        if sender.text?.count == 4 {
            let pin = sender.text!
            if isPinRight(pin: pin) {
                enterToApp()
            } else {
                wrongPIN()
            }
        }
    
    }
    
    
}
