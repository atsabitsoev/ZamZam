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
        
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }
    
    
    func configureView() {
        tfPhoneNumber.layer.cornerRadius = 8
        tfPassword.layer.cornerRadius = 8
        butEnter.layer.cornerRadius = 8
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
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            self.present(mainVC!, animated: true, completion: nil)
            
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
