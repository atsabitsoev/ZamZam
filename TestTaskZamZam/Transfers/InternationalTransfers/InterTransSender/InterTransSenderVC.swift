//
//  InterTransSenderVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 13/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import FlagKit
import PhoneNumberKit

class InterTransSenderVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butNext: UIButton!
    
    @IBOutlet weak var tfPhone: MaterialTextFieldWithFlag!
    @IBOutlet weak var tfName: MaterialTextField!
    @IBOutlet weak var tfLastName: MaterialTextField!
    @IBOutlet weak var tfMiddleName: MaterialTextField!
    @IBOutlet weak var tfBirthDate: MaterialTextField!
    @IBOutlet weak var tfCity: MaterialTextField!
    @IBOutlet weak var tfAdress: MaterialTextField!
    @IBOutlet weak var tfPasportNumber: MaterialTextField!
    @IBOutlet weak var tfPassportAuthority: MaterialTextField!
    @IBOutlet weak var tfPassportDate: MaterialTextField!
    
    
    var userProfile: UserProfileInfo!
    
    var datePicker: UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setTFDelegates()
        setData()
        addRecognizer()
    }
    
    override func viewWillLayoutSubviews() {
        
        configureButNext()
        configureNavigationButtons()
    }
    
    
    private func addRecognizer() {
        
        let rec = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.view.addGestureRecognizer(rec)
    }
    
    @objc private func backgroundTapped() {
        
        self.view.endEditing(true)
    }
    
    
    private func setTFDelegates() {
        
        tfBirthDate.delegate = self
        tfPassportDate.delegate = self
        tfBirthDate.tag = 1
        tfPassportDate.tag = 1
        tfName.delegate = self
        tfLastName.delegate = self
        tfMiddleName.delegate = self
        tfCity.delegate = self
        tfAdress.delegate = self
        tfPasportNumber.delegate = self
        tfPassportAuthority.delegate = self
    }
    
    
    private func setData() {
        
        
        let phone = UserDefaults.standard.string(forKey: "userPhone")!
        tfPhone.text = "\(phone)"
        let phoneNumber = try? PhoneNumberKit().parse(phone)
        if phoneNumber != nil {
            let countryCode = PhoneNumberKit().getRegionCode(of: phoneNumber!)
            tfPhone.imageFlag.image = Flag(countryCode: countryCode ?? "RU")?.image(style: .circle)
        }

        
        tfName.text = userProfile.firstName
        tfLastName.text = userProfile.lastName
        tfMiddleName.text = userProfile.middleName
        tfBirthDate.text = userProfile.birthDate
        tfCity.text = userProfile.city
        tfAdress.text = userProfile.address
        tfPasportNumber.text = userProfile.passportNumber
        tfPassportAuthority.text = userProfile.passportAuthority
        tfPassportDate.text = userProfile.passportIssueDate
    }
    
    
    func showDatePicker(_ textField: MaterialTextField) {
        
        //2. Add the text field. You can configure it however you need.
        self.doDatePicker()
        textField.inputView = self.datePicker
        textField.inputAccessoryView = self.toolBar
        
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
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        self.toolBar.isHidden = false
        
    }
    
    @objc func doneClick() {
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        
        let dateString = dateFormatter1.string(from: datePicker.date)
        if tfBirthDate.isEditing {
            tfBirthDate.text = dateString
        } else if tfPassportDate.isEditing {
            tfPassportDate.text = dateString
        }
        print(dateString)
        
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        self.view.endEditing(true)
    }
    
    @objc func cancelClick() {
        
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        self.view.endEditing(true)
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

    @IBAction func butBackTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butCloseTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
