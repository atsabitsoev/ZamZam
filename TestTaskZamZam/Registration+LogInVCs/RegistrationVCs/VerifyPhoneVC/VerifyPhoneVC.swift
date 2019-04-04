//
//  VerifyPhoneVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 04/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class VerifyPhoneVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tfCountryCode: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var labEnterShortCode: myLabel!
    @IBOutlet weak var tfShortCode: UITextField!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    
    
    let twilioService = TwilioService.standard
    let codeSent = TwilioService.standard.shortCodeSent
    let codeVerified = TwilioService.standard.shortCodeVerified
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
    }
    
    override func viewWillLayoutSubviews() {
        configureView()
    }
    

    func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setVisibleTFs),
                                               name: NSNotification.Name("CodeSent"),
                                               object: nil)
        
    }
    
    func configureView() {
        
        viewBigWhite.layer.cornerRadius = 16
        tfShortCode.layer.cornerRadius = 8
        tfPhoneNumber.layer.cornerRadius = 8
        tfCountryCode.layer.cornerRadius = 8
        butNext.layer.cornerRadius = butNext.bounds.height/2
        butNext.clipsToBounds = true
        setVisibleTFs()
        
    }
    
    @objc func setVisibleTFs() {
        switch codeSent {
        case true:
            UIView.animate(withDuration: 0.3) {
                self.labEnterShortCode.alpha = 1
                self.tfShortCode.alpha = 1
            }
            
        case false:
            UIView.animate(withDuration: 0.3) {
                self.labEnterShortCode.alpha = 0
                self.tfShortCode.alpha = 0
            }
        }
    }
    
    
    @IBAction func butBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butNextTapped(_ sender: Any) {
        if codeSent {
            twilioService.checkShortCode()
        } else {
            twilioService.sendShortCode()
        }
    }
    
}
