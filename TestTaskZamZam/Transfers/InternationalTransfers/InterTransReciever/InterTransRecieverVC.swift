//
//  InterTransReciever.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 11/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit
import FlagKit


var temporaryRecieverPhone = ""


class InterTransRecieverVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var butCountry: ButtonChooseCountryFlag!
    @IBOutlet weak var constrHeightOfBigView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tfPhone: MaterialTextFieldWithFlag!
    @IBOutlet weak var tfName: MaterialTextField!
    @IBOutlet weak var tfLastName: MaterialTextField!
    @IBOutlet weak var tfMiddleName: MaterialTextField!
    
    
    var countryName = ""
    var countryCode = ""
    
    var loaded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addObservers()
        setDelegates()
        addTapRecognizer()
        
        setCountryPhone()
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userProfileGot),
                                               name: NSNotification.Name(NotificationNames.userProfileGot.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userProfileGettingFailed),
                                                name: NSNotification.Name(NotificationNames.userProfileGettingFailed.rawValue),
                                               object: nil)
    }
    
    
    private func setDelegates() {
        
        tfPhone.delegate = self
        tfName.delegate = self
        tfLastName.delegate = self
        tfMiddleName.delegate = self
    }
    
    
    @objc private func userProfileGot() {

        saveRecieverPhone()
        activityIndicator.stopAnimating()
        butNext.isUserInteractionEnabled = true
        
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterTransSenderVC") as! InterTransSenderVC
        senderVC.userProfile = UserProfileService.standard.userProfileInfo!
        self.navigationController?.show(senderVC, sender: nil)
    }
    
    @objc private func userProfileGettingFailed() {
        
        activityIndicator.stopAnimating()
        butNext.isUserInteractionEnabled = true
        
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterTransSenderVC") as! InterTransSenderVC
        senderVC.userProfile = UserProfileInfo(lastName: "",
                                               firstName: "",
                                               middleName: "",
                                               birthDate: "",
                                               countryCode: "",
                                               city: "",
                                               address: "",
                                               passportNumber: "",
                                               passportIssueDate: "",
                                               passportAuthority: "")
        self.navigationController?.show(senderVC, sender: nil)
    }
    
    
    override func viewWillLayoutSubviews() {
        
        configureButNext()
        configureNavigationButtons()
        setCountryToButton()
    }
    
    override func viewDidLayoutSubviews() {
        setConstraints()
    }


    private func saveRecieverPhone() {

        guard let phone = tfPhone.text, phone.count > 4 else { return }
        temporaryRecieverPhone = phone
    }

    
    func setCountryToButton() {
        
        butCountry.countryName = countryName
        butCountry.countryCode = countryCode
        butCountry.layoutSubviews()
    }

    private func setCountryPhone() {

        tfPhone.imageFlag.image = Flag(countryCode: self.countryCode)?.image(style: .circle)
        let phoneCode = PhoneNumberKit().countryCode(for: countryCode)
        if phoneCode != nil {
            tfPhone.text = "+\(phoneCode!)"
        }
    }
    
    
    private func setConstraints() {
        
        if scrollView.frame.height > constrHeightOfBigView.constant {
            
            view.layoutIfNeeded()
            constrHeightOfBigView.constant = scrollView.frame.height
            view.layoutIfNeeded()
            print(constrHeightOfBigView.constant)
            print(viewBigWhite.frame.height)
            print(scrollView.frame.height)
        }
        
    }
    
    
    private func addTapRecognizer() {
        
        let tapRec = UITapGestureRecognizer(target: self,
                                            action: #selector(tap))
        self.scrollView.addGestureRecognizer(tapRec)
    }
    
    @objc private func tap() {
        
        self.view.endEditing(true)
    }
    
    
    func configureButNext() {
        
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

    
    @IBAction func butCountryTapped(_ sender: ButtonChooseCountryFlag) {
        
        let whatCountryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "whatCountryVC") as! WhatCountryVC
        whatCountryVC.interTransRecieverVC = self
        loaded = true
        
        self.navigationController?.show(whatCountryVC, sender: nil)
    }
    
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        
        UserProfileService.standard.getUserInfoRequest()
        activityIndicator.startAnimating()
        butNext.isUserInteractionEnabled = false
    }
    
    
    
    //TFDELEGATE
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}
