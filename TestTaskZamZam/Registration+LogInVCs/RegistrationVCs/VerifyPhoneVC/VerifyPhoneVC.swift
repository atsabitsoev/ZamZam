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
    
    
    var isButtonAvailable = false {
        didSet {
            butSendCode.isUserInteractionEnabled = isButtonAvailable
        }
    }
    var secondsToWait = 60
    
    
    override func viewDidLoad() {
        sendCodeAndStartTimer()
    }
    
    override func viewWillLayoutSubviews() {
        viewBigWhite.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tfCode.becomeFirstResponder()
    }
    
    
    private func codeEntered(code: String) {
        if isCodeRight(code: code) {
            goNext()
            print("code is right")
        } else {
            wrongCode()
            print("code is wrong")
        }
    }
    
    private func isCodeRight(code: String) -> Bool {
        //TODO: Проверка кода
        if code == "123456" {
            return true
        } else {
            return false
        }
    }
    
    private func goNext() {
        let newPasswordVC = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "NewPasswordVC")
        self.navigationController?.show(newPasswordVC, sender: nil)
    }
    
    private func wrongCode() {
        tfCode.text = ""
        dotsView.showableCode = ""
        dotsView.color = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1)
        print(tfCode.text?.count)
    }
    
    private func sendCode() {
        //TODO: Отправить код
        print("Отправляю код")
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
    
    private func sendCodeAndStartTimer() {
        sendCode()
        startTimer()
    }
    
    
    
    @IBAction func tFCodeTextChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let codeLength = sender.text!.count
        dotsView.showableCode = sender.text!
        if codeLength == dotsView.totalDots {
            codeEntered(code: sender.text!)
        }
    }
    
    @IBAction func butSendCodeTapped(_ sender: UIButton) {
        sendCodeAndStartTimer()
    }
    
}
