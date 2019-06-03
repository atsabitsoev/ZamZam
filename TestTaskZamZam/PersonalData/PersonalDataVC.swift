//
//  PersonalDataVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PersonalDataVC: UIViewController {

    
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var butCountry: ButtonChooseCountry!
    
    
    @IBOutlet weak var tfPhone: MaterialTextFieldWithFlag!
    @IBOutlet weak var tfFirstName: MaterialTextField!
    @IBOutlet weak var tfLastName: MaterialTextField!
    @IBOutlet weak var tfFathersName: MaterialTextField!
    @IBOutlet weak var tfBirthDate: MaterialTextField!
    @IBOutlet weak var tfCity: MaterialTextField!
    @IBOutlet weak var tfAddress: MaterialTextField!
    @IBOutlet weak var tfPassportNumber: MaterialTextField!
    @IBOutlet weak var tfPassportAuthority: MaterialTextField!
    @IBOutlet weak var tfPassportIssueDate: MaterialTextField!
    
    
    var datePicker:UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    
    var country: String = "Россия"
    var countryCode: String = "RU"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTFDelegates()
        configureScrollView()
        setUserProfileInfo()
    }
    
    override func viewWillLayoutSubviews() {
        configureButNext()
        configureNavigationButtons()
    }
    
    
    private func setTFDelegates() {
        
        tfBirthDate.delegate = self
        tfPassportIssueDate.delegate = self
    }
    
    private func configureScrollView() {
        
        scrlView.layer.cornerRadius = 16
    }
    
    private func configureButNext() {
        
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
    
    private func configureNavigationButtons() {
        
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
    
    func showDatePicker(_ textField: MaterialTextField) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            self.doDatePicker()
            textField.inputView = self.datePicker
            textField.inputAccessoryView = self.toolBar
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if textField?.text != ""{
                print("Text field: \(textField?.text!)")
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func doDatePicker() {
    
    self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: self.view.frame.size.height - 220, width:self.view.frame.size.width, height: 216))
    self.datePicker.backgroundColor = UIColor.white
    datePicker.datePickerMode = .date
    
    // ToolBar
    
    toolBar.barStyle = .default
    toolBar.isTranslucent = true
    toolBar.tintColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.5058823529, alpha: 1)
    toolBar.sizeToFit()
    
    // Adding Button ToolBar
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
    toolBar.isUserInteractionEnabled = true
    
    self.toolBar.isHidden = false
    
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func cancelClick() {
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    private func setUserProfileInfo() {
        
        guard let userProfileInfo = UserProfileService.standard.userProfileInfo else { return }
        
        let userPhone = UserDefaults.standard.string(forKey: "userPhone")
        tfPhone.text = userPhone
        
        guard userProfileInfo.firstName != "" else {
            return
        }
        
        setSavedCountry()
        
        tfFirstName.text = userProfileInfo.firstName
        tfLastName.text = userProfileInfo.lastName
        tfFathersName.text = userProfileInfo.middleName
        tfBirthDate.text = userProfileInfo.birthDate
        tfCity.text = userProfileInfo.city
        tfAddress.text = userProfileInfo.address
        tfPassportNumber.text = userProfileInfo.passportNumber
        tfPassportAuthority.text = userProfileInfo.passportAuthority
        tfPassportIssueDate.text = userProfileInfo.passportIssueDate
        butCountry.setTitle(country, for: .normal)
    }
    
    private func setSavedCountry() {
        
        country = UserDefaults.standard.string(forKey: "PersonalDataCountryName") ?? "Россия"
        countryCode = UserDefaults.standard.string(forKey: "PersonalDataCountryCode") ?? "RU"
        
    }
    
    private func emptyFields() -> [UITextField] {
        
        var emptyFields: [UITextField] = []
        
        let allFields = [tfPhone, tfFirstName, tfLastName, tfBirthDate, tfCity, tfAddress, tfPassportNumber, tfPassportAuthority, tfPassportIssueDate]
        
        for tf in allFields {
            
            if tf!.text == nil || tf!.text == "" || tf!.text == " " {
                emptyFields.append(tf!)
            }
        }
        
        return emptyFields
    }
    
    private func makeRed(_ masTextFields: [MaterialTextField]) {
        
        for tf in masTextFields {
            
            tf.inActiveColor = #colorLiteral(red: 0.9803921569, green: 0.4666666667, blue: 0.5294117647, alpha: 1)
            tf.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.4666666667, blue: 0.5294117647, alpha: 1)
        }
    }
    
    
    func updateButCountry() {
        butCountry.setTitle(country, for: .normal)
    }
    
    
    @IBAction func butSaveTapped(_ sender: UIButton) {
        
        guard emptyFields().isEmpty else {
            makeRed(emptyFields() as! [MaterialTextField])
            return
        }
        
        let userProfileInfo = UserProfileInfo(lastName: tfLastName.text!,
                                              firstName: tfFirstName.text!,
                                              middleName: tfFathersName.text!,
                                              birthDate: tfBirthDate.text!,
                                              countryCode: countryCode,
                                              city: tfCity.text!,
                                              address: tfAddress.text!,
                                              passportNumber: tfPassportNumber.text!,
                                              passportIssueDate: tfPassportIssueDate.text!,
                                              passportAuthority: tfPassportAuthority.text!)
        print(countryCode)
        UserDefaults.standard.set(countryCode, forKey: "PersonalDataCountryCode")
        UserDefaults.standard.set(country, forKey: "PersonalDataCountryName")
        
        UserProfileService.standard.postUserInfoRequest(userProfileInfo: userProfileInfo)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PersonalDataToCountries" {
            
            let whatCountriesVC = segue.destination as! WhatCountryVC
            whatCountriesVC.personalDataVC = self
            
        }
        
    }

}
