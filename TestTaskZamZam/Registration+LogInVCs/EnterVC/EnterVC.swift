//
//  EnterVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 05/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import KeychainSwift

class EnterVC: UIViewController {
    
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var labErrorMessage: UILabel!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let keychain = KeychainSwift()
    let enterService = EnterServise()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        addGestureRec()
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }
    
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enterFailed),
                                               name: NSNotification.Name(rawValue: EnterNotificationNames.enterFailed.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(wrongPasswordEntered),
                                               name: NSNotification.Name(rawValue: EnterNotificationNames.wrongCredentials.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(goToMainVC),
                                               name: NSNotification.Name(rawValue: EnterNotificationNames.enterSucceed.rawValue),
                                               object: nil)
        
    }
    
    @objc func enterFailed() {
        print("error of login")
        activityIndicator.stopAnimating()
    }
    
    @objc func goToMainVC() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.present(mainVC!, animated: true, completion: nil)
        activityIndicator.stopAnimating()
    }
    
    @objc func wrongPasswordEntered() {
        labErrorMessage.alpha = 1
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
    
    
    @IBAction func tFPhoneNumberTextChanged(_ sender: UITextField) {
        TFService.checkPrefix(prefix: "+", sender)
    }
    
    @IBAction func butEnterTapped(_ sender: UIButton) {
        
        guard let phone = tfPhoneNumber.text else { return }
        guard let password = tfPassword.text else { return }
        
        enterService.enter(phone: phone, password: password)
        activityIndicator.startAnimating()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
