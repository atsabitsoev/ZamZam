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


class MaterialTextFieldWithFlag: MaterialTextField {
    
    
    private let pading = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 5)
    
    let imageFlag = UIImageView()
    private var code: String?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.placeholder = title
        
        addTarget(self, action: #selector(setCountryFlag), for: .editingChanged)
    }
    
    
    override func layoutSubviews() {
        configureImage()
        super.configureLabTitle()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = bounds.inset(by: pading)
        return newBounds
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = bounds.inset(by: pading)
        print(newBounds)
        return newBounds
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = bounds.inset(by: pading)
        return newBounds
    }
    
    
    private func configureImage() {
        
        superview!.addSubview(imageFlag)
        
        let titleFrame = CGRect(x: 10 + frame.minX, y: 7 + frame.minY, width: 30, height: 30)
        imageFlag.frame = titleFrame
        
    }
    
    
    @objc private func setCountryFlag() -> Bool {
        
        let phoneNumberKit = PhoneNumberKit()
        
        guard let code = text else {
            hideFlag()
            return false
        }
        
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
    
    private func hideFlag() {
        imageFlag.isHidden = true
    }
    
    private func showFlag() {
        imageFlag.isHidden = false
    }
    
}
