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
    
    
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var butEnter: UIButton!
    
    
    let keychain = KeychainSwift()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRec()
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }
    
    
    func addGestureRec() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    @objc func hideKeyboard() {
        self.becomeFirstResponder()
        self.view.endEditing(true)
    }
    
    func configureView() {
        tfPhoneNumber.layer.cornerRadius = 8
        tfPassword.layer.cornerRadius = 8
        butEnter.layer.cornerRadius = 8
    }
    
    func goToMainVC() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.present(mainVC!, animated: true, completion: nil)
    }
    
    func rememberUser(phone: String) {
        UserDefaults.standard.set(true, forKey: "userEntered")
        UserDefaults.standard.setValue(phone, forKey: "userPhone")
    }
    
    
    @IBAction func tFPhoneNumberTextChanged(_ sender: UITextField) {
        TFService.checkPrefix(prefix: "+", sender)
    }
    
    @IBAction func tfPasswordTextChanged(_ sender: UITextField) {
    }
    
    @IBAction func butEnterTapped(_ sender: UIButton) {
        
        guard let phone = tfPhoneNumber.text else { return }
        guard let password = tfPassword.text else { return }
        guard let rightPassword = keychain.get(phone) else { return }
        
        if password == rightPassword {
            rememberUser(phone: phone)
            goToMainVC()
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
