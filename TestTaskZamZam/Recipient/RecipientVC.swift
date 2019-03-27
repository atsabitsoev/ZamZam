//
//  RecipientVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit
import FlagKit

class RecipientVC: UIViewController, UITextFieldDelegate {
    
    
    
    
    @IBOutlet weak var viewWhiteBig: UIView!
    @IBOutlet weak var viewRecipient: UIView!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    
    
    
    var currentRegion: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        
    }
    
    
    override func viewWillLayoutSubviews() {
        viewWhiteBig.layer.cornerRadius = 16
        
        viewRecipient.layer.cornerRadius = 8
        viewRecipient.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        viewRecipient.layer.borderWidth = 2
        
        configureButNext()
        configureNavigationButtons()
        imCountry.layer.cornerRadius = imCountry.bounds.width/2
        imCountry.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setImageOfCountry()
    }
    

    func setImageOfCountry() {

        let flag = Flag(countryCode: currentRegion!)
        imCountry.image = flag?.image(style: .circle)
        
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
    
    
    func configureTextField() {
        
        if let region = currentRegion {
            let phoneNumberKit = PhoneNumberKit()
            let countryCode = phoneNumberKit.countryCode(for: region)
            tfPhoneNumber.text = "+\(countryCode!)"
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(recognizer)
        
    }
    
    
    @IBAction func tfEditingChanged(_ sender: Any) {
        
        let phoneNumberKit = PhoneNumberKit()
        let formatter = PartialFormatter(phoneNumberKit: phoneNumberKit,
                                         defaultRegion: currentRegion!,
                                         withPrefix: (phoneNumberKit.countryCode(for: currentRegion!) != nil))
        let textOfNumber = tfPhoneNumber.text
        tfPhoneNumber.text = formatter.formatPartial(textOfNumber!)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
