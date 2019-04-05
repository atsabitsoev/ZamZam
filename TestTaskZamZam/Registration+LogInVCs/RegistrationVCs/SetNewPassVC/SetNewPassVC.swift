//
//  SetNewPassVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 05/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import KeychainSwift

class SetNewPassVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfRepeatPassword: UITextField!
    @IBOutlet weak var butEnter: UIButton!
    
    
    let keychain = KeychainSwift()
    var phoneNumber: String? = "89"
    let minPasswordCharacters = 8
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    
    func configureView() {
        viewBigWhite.layer.cornerRadius = 16
        tfNewPassword.layer.cornerRadius = 8
        tfRepeatPassword.layer.cornerRadius = 8
        butEnter.layer.cornerRadius = 8
    }
    
    func savePass() {
        guard let pass = tfNewPassword.text else { return }
        guard let repeatedPass = tfRepeatPassword.text else { return }
        guard pass == repeatedPass else { return }
        guard let phoneNumber = phoneNumber else { return }
        
        keychain.set(pass, forKey: phoneNumber)
    }
    
    func goToEnterVC() {
        self.navigationController
    }
    
    
    @IBAction func tFNewPasswordTextChanged(_ sender: UITextField) {
        
        TFService.checkMaxCharacters(count: 20, field: sender)
        
    }
    
    @IBAction func tFRepeatPasswordTextChanged(_ sender: UITextField) {
        TFService.checkMaxCharacters(count: 20, field: sender)
    }
    
    @IBAction func butEnterTapped(_ sender: UIButton) {
        savePass()
        goToEnterVC()
    }
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
