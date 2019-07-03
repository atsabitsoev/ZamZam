//
//  EnterVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 05/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import KeychainSwift
import PhoneNumberKit
import FlagKit

class EnterVC: UIViewController {
    
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var labErrorMessage: UILabel!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet var labTitlePhone: UILabel!
    @IBOutlet var labTitlePassword: UILabel!

    
    let keychain = KeychainSwift()
    let enterService = EnterServise.standard
    
    
    private var currentCode = "+"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        addGestureRec()

        setDefaultRegion()
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tfPhoneNumber.becomeFirstResponder()
    }


    private func setDefaultRegion() {

        let countryCode = Locale.current.regionCode!

        let phoneCode = PhoneNumberKit().countryCode(for: countryCode)!
        tfPhoneNumber.text = "+\(phoneCode)"

        let flag = Flag(countryCode: countryCode)
        imCountry.image = flag?.image(style: .circle)
    }
    
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enterFailed),
                                               name: NSNotification.Name(rawValue: NotificationNames.enterFailed.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(wrongPasswordEntered),
                                               name: NSNotification.Name(rawValue: NotificationNames.wrongCredentials.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(goNext),
                                               name: NSNotification.Name(rawValue: NotificationNames.enterSucceed.rawValue),
                                               object: nil)
        
    }
    
    @objc func enterFailed() {
        print("error of login")
        labErrorMessage.alpha = 1
        labErrorMessage.text = "Ошибка сервера"
        activityIndicator.stopAnimating()
    }
    
    @objc func goNext() {
        
        guard var phone = tfPhoneNumber.text else { return }
        guard let password = tfPassword.text else { return }
        phone = "+\(phone.onlyNumbers())"
        rememberUser(phone: phone)
        
        let newPinVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "SetNewPinEnterVC")
        self.navigationController?.show(newPinVC, sender: nil)
        activityIndicator.stopAnimating()
    }
    
    @objc func wrongPasswordEntered() {
        labErrorMessage.alpha = 1
        labErrorMessage.text = "Неверный логин или пароль"
        activityIndicator.stopAnimating()
    }
    
    func addGestureRec() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    @objc func hideKeyboard() {
        self.becomeFirstResponder()
        self.view.endEditing(true)
    }
    
    func configureView() {
        viewMain.layer.cornerRadius = 16
        tfPhoneNumber.layer.cornerRadius = 8
        tfPassword.layer.cornerRadius = 8
        configureButNext()
        setBordersToTextFields()
    }
    
    func setBordersToTextFields() {
        viewPhoneNumber.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        viewPhoneNumber.layer.borderWidth = 2
        viewPhoneNumber.layer.cornerRadius = 8
        viewPassword.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        viewPassword.layer.borderWidth = 2
        viewPassword.layer.cornerRadius = 8
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
    
    func rememberUser(phone: String) {
        
        UserDefaults.standard.set(true, forKey: "userEntered")
        UserDefaults.standard.setValue(phone, forKey: "userPhone")
        
    }
    
    private func goToResetPassNavCon() {
        
        let storyboard = UIStoryboard(name: "Registration+LogIn", bundle: nil)
        let regLogNavCon = storyboard.instantiateViewController(withIdentifier: "ResetPassNavCon")
        self.present(regLogNavCon, animated: true, completion: nil)
        
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


    private func activatePhoneTF(_ activate: Bool) {

        labTitlePhone.isHidden = !activate
    }

    private func activatePasswordTF(_ activate: Bool) {

        labTitlePassword.isHidden = !activate
    }
    
    
    @IBAction func tFPhoneNumberTextChanged(_ sender: UITextField) {

        TFService.checkPrefix(prefix: "+", tfPhoneNumber)
        guard let text = sender.text else { return }

        activatePhoneTF(text.count > 0)

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


    @IBAction func tfPasswordTextChanged(_ sender: UITextField) {

        activatePasswordTF((sender.text?.count ?? 0) > 0)
    }


    @IBAction func butEnterTapped(_ sender: UIButton) {
        
        guard var phone = tfPhoneNumber.text else { return }
        guard let password = tfPassword.text else { return }
        phone = "+\(phone.onlyNumbers())"
        
        enterService.enter(phone: phone, password: password)
        activityIndicator.startAnimating()
    }
    
    
    @IBAction func butForgonPasswordTapped(_ sender: UIButton) {
        
        goToResetPassNavCon()
        setNewPasswordModeON = true
        
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
