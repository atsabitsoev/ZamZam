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
    
    
    override func viewDidLoad() {
        
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
        //TODO: Переход на следующий экран
    }
    
    private func wrongCode() {
        tfCode.text = ""
        dotsView.showableCode = ""
        dotsView.color = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1)
        print(tfCode.text?.count)
    }
    
    
    @IBAction func tFCodeTextChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let codeLength = sender.text!.count
        dotsView.showableCode = sender.text!
        if codeLength == dotsView.totalDots {
            codeEntered(code: sender.text!)
        }
    }
}
