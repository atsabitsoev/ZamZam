//
//  TestVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 07/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TestVC: UIViewController {
    
    
    @IBOutlet weak var tfCode: UITextField!
    let verifService = PhoneVerificationService.standard
    let registrationService = RegistrationService.standard
    
    let phone = "+79777872475"
    let password = "MyPassword"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verifService.verify(phone: phone)

    }
    
    
    
    
    
    @IBAction func sendCode(_ sender: UIButton) {
        
        guard let code = tfCode.text else { return }
        print("сейчас отправлю код")
        verifService.checkVerification(code: code)
        
    }
    
    
    @IBAction func registration(_ sender: UIButton) {
        
        registrationService.register(phone: phone, password: password)
        
    }
}
