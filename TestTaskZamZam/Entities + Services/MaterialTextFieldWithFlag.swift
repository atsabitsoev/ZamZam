//
//  MaterialTextFieldWithFlag.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import FlagKit
import PhoneNumberKit


class MaterialTextFieldWithFlag: UITextField {
    
    
    @IBInspectable var inActiveColor: UIColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
    @IBInspectable var activeColor: UIColor = #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1)
    @IBInspectable var title: String = "Заголовок"
    
    
    var padding = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 5)
    
    
    private lazy var labTitle: MaterialTextFieldLabTitle = MaterialTextFieldLabTitle()
    
    let imageFlag = UIImageView()
    var code: String?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 8
        layer.borderColor = inActiveColor.cgColor
        layer.borderWidth = 2

        setCurrentRegion()
        configureLabTitle()
        
        addTarget(self, action: #selector(setCountryFlag), for: .editingChanged)
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureImage()
        configureLabTitle()
        layoutIfNeeded()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = bounds.inset(by: padding)
        return newBounds
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = bounds.inset(by: padding)
        print(newBounds)
        return newBounds
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = bounds.inset(by: padding)
        return newBounds
    }
    
    
    private func configureImage() {
        
        superview!.addSubview(imageFlag)
        
        let titleFrame = CGRect(x: 10 + frame.minX, y: 10 + frame.minY, width: 30, height: 30)
        imageFlag.frame = titleFrame
        
    }
    
    func configureLabTitle() {
        
        superview?.addSubview(labTitle)
        
        let titleFrame = CGRect(x: 11 + frame.minX, y: -5 + frame.minY, width: bounds.width - 22, height: 9)
        labTitle.frame = titleFrame
        print(titleFrame)
        labTitle.text = title
        labTitle.adjustsFontSizeToFitWidth = true
        labTitle.sizeToFit()
        labTitle.backgroundColor = .white
        labTitle.font = UIFont(name: "PT Sans", size: 9)
        labTitle.textColor = isEditing ? activeColor : #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
        
    }
    
    
    @objc private func setCountryFlag() -> Bool {
        
        let phoneNumberKit = PhoneNumberKit()
        
        guard var code = text?.onlyNumbers() else {
            hideFlag()
            return false
        }
        code = "+\(code)"
        
        guard let countryCode = UInt64(code) else {
            hideFlag()
            return false
        }
        
        guard let country = phoneNumberKit.mainCountry(forCode: countryCode) else {
            return false
        }
        
        let flagImage = Flag(countryCode: country)?.image(style: .circle)
        imageFlag.image = flagImage
        self.code = code
        showFlag()
        return true
    }
    
    @objc private func editingBegan() {
        
        labTitle.isHidden = false
        layer.borderColor = activeColor.cgColor
        setNeedsDisplay()
    }
    
    @objc private func editingEnded() {
        
        if text == nil || text == "" {
            labTitle.isHidden = true
        }
        layer.borderColor = inActiveColor.cgColor
        setNeedsDisplay()
    }
    
    private func hideFlag() {
        imageFlag.isHidden = true
    }
    
    private func showFlag() {
        imageFlag.isHidden = false
    }


    private func setCurrentRegion() {
        print("jfdikfsifns")
        let region = Locale.current.regionCode
        let code = PhoneNumberKit().countryCode(for: region!)

        let flag = Flag(countryCode: region!)
        let codeString = "+\(code!)"

        text = codeString
        imageFlag.image = flag?.image(style: .circle)
    }
    
}
