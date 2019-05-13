//
//  VerifyPhoneVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 04/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class VerifyPhoneVC: UIViewController {
    
    
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var dotsView: DotsView!
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var butSendCode: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var isButtonAvailable = false {
        didSet {
            butSendCode.isUserInteractionEnabled = isButtonAvailable
        }
    }
    var secondsToWait = 60
    
    
    let phoneVerificationService = PhoneVerificationService.standard
    
    
    override func viewDidLoad() {
        addObservers()
        startTimer()
    }
    
    override func viewWillLayoutSubviews() {
        viewBigWhite.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tfCode.becomeFirstResponder()
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(codeSent),
                                               name: NSNotification.Name(PhoneVerificationNotificationNames.codeSent.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(wrongCode),
                                               name: NSNotification.Name(PhoneVerificationNotificationNames.verificationFailed.rawValue), object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(goNext),
                                               name: NSNotification.Name(PhoneVerificationNotificationNames.verificationSucceed.rawValue), object: nil)
    }
    
    
    @objc private func goNext() {
        
        let newPasswordVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "NewPasswordVC")
        self.navigationController?.show(newPasswordVC, sender: nil)
        activityIndicator.stopAnimating()
        
    }
    
    @objc private func codeSent() {
        
        activityIndicator.stopAnimating()
        
    }
    
    @objc private func wrongCode() {
        
        tfCode.text = ""
        dotsView.showableCode = ""
        dotsView.color = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1)
        print(tfCode.text?.count ?? "error")
        activityIndicator.stopAnimating()
        
    }
    
    private func startTimer() {
        
        isButtonAvailable = false
        secondsToWait = 60
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            self.secondsToWait -= 1
            
            UIView.setAnimationsEnabled(false)
            self.butSendCode.setTitle("Повторный код через \(self.secondsToWait) сек", for: .normal)
            UIView.setAnimationsEnabled(true)
            
            if self.secondsToWait <= 0 {
                
                timer.invalidate()
                self.secondsToWait = 60
                self.isButtonAvailable = true
                UIView.setAnimationsEnabled(false)
                self.butSendCode.setTitle("Отправить код", for: .normal)
                UIView.setAnimationsEnabled(true)
                
            }
            
        }
        
    }
    
    private func sendCode() {
        
        phoneVerificationService.verify(phone: temporaryPhone)
        activityIndicator.startAnimating()
        
    }
    
    private func sendCodeAndStartTimer() {
        sendCode()
        startTimer()
    }
    
    
    @IBAction func tFCodeTextChanged(_ sender: UITextField) {
        guard sender.text != nil else { return }
        let codeLength = sender.text!.count
        dotsView.showableCode = sender.text!
        if codeLength == dotsView.totalDots {
            phoneVerificationService.checkVerification(code: tfCode.text!)
            activityIndicator.startAnimating()
        } else if codeLength > dotsView.totalDots {
            sender.text = String((sender.text?.dropLast(codeLength - dotsView.totalDots))!)
        }
    }
    
    @IBAction func butSendCodeTapped(_ sender: UIButton) {
        sendCodeAndStartTimer()
    }
    
}
