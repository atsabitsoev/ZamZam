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
import PhoneNumberKit

class PIN_VC: UIViewController {

    
    @IBOutlet weak var tfPin: UITextField!
    @IBOutlet weak var labUser: myLabel!
    @IBOutlet weak var dotsView: DotsView!
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let keychain = KeychainSwift()
    let userTokenService = UserTokenService.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        
        dotsView.totalDots = 4
        
        setTextToLabUser()
        
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
    
    
    private func setTextToLabUser() {

        if let userName = UserDefaults.standard.string(forKey: "userFirstName") {
            let userLastName = UserDefaults.standard.string(forKey: "userLastName")!
            let helloString = "\(userName) \(userLastName) 👋"
            labUser.text = helloString
            return
        }
        
        guard let userName = UserDefaults.standard.string(forKey: "userPhone") else { return }
        
        let formattedUserName = PartialFormatter().formatPartial(userName)
        
        labUser.text = formattedUserName
        
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
                            self.tryToEnterToApp()
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
    
    func tryToEnterToApp() {
        
        activityIndicator.startAnimating()
        userTokenService.updateTokens()
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterToApp), name: NSNotification.Name(NotificationNames.enterSucceed.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showError), name: NSNotification.Name(NotificationNames.enterFailed.rawValue), object: nil)
        
    }
    
    @objc private func enterToApp() {
        
        activityIndicator.stopAnimating()
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTBController")
        self.present(home, animated: true, completion: nil)
        
    }
    
    @objc private func showError() {
        
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка", message: "Упс, произошла неизвестная ошибка", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style:  .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
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
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        let regLogNavCon = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "RegLogNavCon")
        self.show(regLogNavCon, sender: nil)
    }
    
    
    @IBAction func tFPinTextChanged(_ sender: UITextField) {
        guard sender.text != nil else { return }
        
        dotsView.solidDots = sender.text!.count
        
        if sender.text?.count == 4 {
            let pin = sender.text!
            if isPinRight(pin: pin) {
                tryToEnterToApp()
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
