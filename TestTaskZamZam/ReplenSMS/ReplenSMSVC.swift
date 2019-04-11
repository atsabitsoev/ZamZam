//
//  ReplenSMSVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 09/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
var alertOpened = false
class ReplenSMSVC: UIViewController {
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var viewSMSCode: UIView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var butBack: UIButton!
    
    
    var buttonsConfigured = (false, false)
    let phoneNumber = "+79777872475"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber = UserDefaults.standard.string(forKey: "userPhone")
        
        viewBigWhite.layer.cornerRadius = 16
        
        addObservers()
        
        if timerService != nil {
            invalidateButNext()
        } else {
            butNextTapped()
        }
        
        addGestureRec()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if alertOpened {
            self.navigationController?.dismiss(animated: true, completion: nil)
            alertOpened = false
        }
    }
    
    override func viewWillLayoutSubviews() {
        configureViewSMSCode()
        if !buttonsConfigured.0 {
            buttonsConfigured.0 = true
        } else if !buttonsConfigured.1 {
            configureNavigationButtons()
            configureButNext()
            buttonsConfigured.1 = true
            print("buttonsconfigured")
        }
        
    }
    
    
    func addObservers() {
        let center = NotificationCenter.default
        center.addObserver(self,
                        selector: #selector(secondPast),
                        name: NSNotification.Name(rawValue: "SecondPast"),
                        object: nil)
        center.addObserver(self,
                           selector: #selector(timerStopped),
                           name: NSNotification.Name(rawValue: "TimerStopped"),
                           object: nil)
        center.addObserver(self,
                           selector: #selector(verificationSucceed),
                           name: NSNotification.Name(NotificationType.codeVerified.rawValue),
                           object: nil)
    }
    
    func configureViewSMSCode() {
        
        viewSMSCode.layer.cornerRadius = 8
        viewSMSCode.layer.borderWidth = 2
        viewSMSCode.layer.borderColor = #colorLiteral(red: 0.1166388467, green: 0.1620907187, blue: 0.407119751, alpha: 1)
        
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
    
    func configureNavigationButtons() {
        
        butBack.layer.cornerRadius = butBack.bounds.height/2
        butBack.layer.shadowOffset = CGSize(width: 0, height: 6)
        butBack.layer.shadowRadius = 16
        butBack.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        butBack.layer.shadowOpacity = 0.18
        let rightImage = UIImage(named: "chevronRight")?.cgImage
        let leftImage = UIImage(cgImage: rightImage!, scale: 0, orientation: UIImage.Orientation.down)
        butBack.setImage(leftImage, for: .normal)
        butBack.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        
        butClose.layer.cornerRadius = butClose.bounds.height/2
        butClose.layer.shadowOffset = CGSize(width: 0, height: 6)
        butClose.layer.shadowRadius = 16
        butClose.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        butClose.layer.shadowOpacity = 0.18
        butClose.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    }
    
    func invalidateButNext() {
        butNext.isUserInteractionEnabled = false
        butNext.alpha = 0.5
    }
    
    func sendCode(phone: String) {
        TwilioService.standard.sendShortCode(phone: phone)
    }
    
    func checkCode(code: String) {
        TwilioService.standard.checkShortCode(code: code)
    }
    
    func validateButNext() {
        let title = "Отправить код"
        UIView.setAnimationsEnabled(false)
        butNext.setTitle(title, for: .normal)
        UIView.setAnimationsEnabled(true)
        butNext.isUserInteractionEnabled = true
        butNext.alpha = 1
    }
    
    func butNextTapped() {
        sendCode(phone: phoneNumber)
        timerService = TimerService(time: 60)
        invalidateButNext()
    }
    
    func presentAlertVC() {
        let replenishGoneVC = UIStoryboard(name: "AlertViewControllers",
                                           bundle: nil).instantiateViewController(withIdentifier: "ReplenishGoneVC") as! ReplenishGoneVC
        alertOpened = true
        self.present(replenishGoneVC, animated: true)
    }
    
    func addGestureRec() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    
    @objc func hideKeyboard() {
        self.becomeFirstResponder()
        self.view.endEditing(true)
    }
    
    
    @objc func secondPast() {
        print("second")
        let timeRest = timerService?.timeRest
        let title = "Отправить код через \(timeRest!) сек"
        UIView.setAnimationsEnabled(false)
        butNext.setTitle(title, for: .normal)
        UIView.setAnimationsEnabled(true)
    }
    
    @objc func timerStopped() {
        timerService = nil
        validateButNext()
    }
    
    @objc func verificationSucceed() {
        presentAlertVC()
    }
    
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        butNextTapped()
    }
    
    @IBAction func tfCodeTextChanged(_ sender: UITextField) {
        
        if let text = sender.text, text.count == 6 {
            checkCode(code: text)
        }
        
    }
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
}
