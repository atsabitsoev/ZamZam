//
//  NewPasswordVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 25/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class NewPasswordVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var viewNewPassword: UIView!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var labErrorNewPassword: myLabel!
    @IBOutlet weak var viewRepeatPassword: UIView!
    @IBOutlet weak var tfRepeatPassword: UITextField!
    @IBOutlet weak var labErrorRepeatPassword: myLabel!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsForTextFields()
        
        if setNewPasswordModeON {
            addResetPasswordObservers()
        } else {
            addRegistrationObservers()
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        
        setBoardsToViews([viewNewPassword, viewRepeatPassword], color: #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1))
        viewBigWhite.layer.cornerRadius = 16
        configureButNext()
        
    }
    
    
    private func addRegistrationObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(registrationFailed),
                                               name: NSNotification.Name(RegistrationNotificationNames.registrationFailed.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userExistsError),
                                               name: NSNotification.Name(RegistrationNotificationNames.userExists.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(registrationSucceed),
                                               name: NSNotification.Name(RegistrationNotificationNames.registrationSucceed.rawValue),
                                               object: nil)
        
    }
    
    private func addResetPasswordObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(passwordChanged),
                                               name: NSNotification.Name(ResetPasswordNotificationNames.passwordChanged.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(passwordNotChanged),
                                               name: NSNotification.Name(ResetPasswordNotificationNames.passwordNotChanged.rawValue),
                                               object: nil)
        
    }
    
    @objc func passwordChanged() {
        
        goToRegLogNavCon()
        activityIndicator.stopAnimating()
        
    }
    
    @objc func passwordNotChanged() {
        
        let alert = UIAlertController(title: "Ошибка", message: "Возникла непредвиденная ошибка!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        activityIndicator.stopAnimating()
        
    }
    
    @objc private func registrationFailed() {
        
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка", message: "Проверьте подключение к интернету", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func userExistsError() {
        
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка", message: "Пользователь уже существует", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func registrationSucceed() {
        
        activityIndicator.stopAnimating()
        
        goNext()
        
    }
    
    private func goToRegLogNavCon() {
        
        let storyboard = UIStoryboard(name: "Registration+LogIn", bundle: nil)
        let regLogNavCon = storyboard.instantiateViewController(withIdentifier: "RegLogNavCon")
        self.present(regLogNavCon, animated: true, completion: nil)
        
    }
    
    private func settingsForTextFields() {
        
        tfNewPassword.delegate = self
        tfNewPassword.tag = 0
        tfRepeatPassword.delegate = self
        tfRepeatPassword.tag = 1
        
    }
    
    private func setBoardsToViews(_ masViews: [UIView], color: UIColor) {
        
        for view in masViews {
            
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = 2
            view.layer.cornerRadius = 8
            
        }
        
    }
    
    func showError(_ error: PasswordErrors) {
        
        switch error {
            
        case .needCapitalLetter, .needMoreSymbols:
            
            labErrorNewPassword.alpha = 1
            labErrorNewPassword.text = error.rawValue
            
        case .differentPasswords:
            
            labErrorRepeatPassword.alpha = 1
            labErrorRepeatPassword.text = error.rawValue
            
        }
        
    }
    
    func hideLabError(tag: Int) {
        
        switch tag {
            
        case 0:
            
            labErrorNewPassword.alpha = 0
            
        case 1:
            
            labErrorRepeatPassword.alpha = 0
            
        default:
            
            print("Wrong tag of error lab")
            
        }
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
    
    func goNext() {
        
        let setNewPinVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "SetNewPINVC")
        self.navigationController?.show(setNewPinVC, sender: nil)
        
    }
    
    func rememberPassword(_ password: String) {
        
        temporaryPass = password
        
    }
    
    private func deactivateButNext() {
        
        butNext.alpha = 0.5
        
    }
    
    private func activateButNext() {
        
        butNext.alpha = 1
        
    }
    
    private func registerUser(phone: String, password: String) {
        
        activityIndicator.startAnimating()
        RegistrationService.standard.register(phone: phone, password: password)
        
    }
    
    func keyboardReturnButtonTapped() {
        
        butNextTapped(butNext)
        
    }
    
    
    @IBAction func tfTextChanged(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        
        switch sender.tag {
            
        case 0:
            
            if text.count < 8 {
                
                print(text)
                showError(.needMoreSymbols)
                deactivateButNext()
                
            } else if !PasswordSymbolManager.containsBigLetter(text) {
                
                showError(.needCapitalLetter)
                deactivateButNext()
                
            } else {
                
                hideLabError(tag: sender.tag)
                
                if self.tfRepeatPassword.text != self.tfNewPassword.text {
                    
                    showError(.differentPasswords)
                    deactivateButNext()
                    
                } else {
                    
                    hideLabError(tag: sender.tag)
                    activateButNext()
                    rememberPassword(text)
                    
                }
                
            }
            
        case 1:
            
            if self.tfRepeatPassword.text != self.tfNewPassword.text {
                
                showError(.differentPasswords)
                deactivateButNext()
                
            } else {
                
                hideLabError(tag: sender.tag)
                rememberPassword(text)
                activateButNext()
                
            }
            
        default:
            
            print("what")
            
        }
        
    }
    
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        
        if setNewPasswordModeON {
            
            activityIndicator.startAnimating()
            ResetPasswordService.standard.setNewPassword(temporaryPass)
            
        } else {
            
            registerUser(phone: temporaryPhone, password: temporaryPass)
            
        }
        
    }
    
    
    
}
    
    
    

