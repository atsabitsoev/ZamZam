//
//  ButtonChooseCountryFlag.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 11/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import FlagKit


class ButtonChooseCountryFlag: UIButton {
    
    
    private lazy var labTitle: MaterialTextFieldLabTitle = MaterialTextFieldLabTitle()
    lazy var labCountry = UILabel()
    private lazy var imageViewChevron = UIImageView()
    lazy var imageViewCountry = UIImageView()
    
    
    var countryCode = "RU"
    var countryName = "Россия"
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 8
        layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1).cgColor
        layer.borderWidth = 2
        
        addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLabTitle()
        configureLabCountry()
        configureImageViewChevron()
        configureImageViewCountry()
        layoutIfNeeded()
    }
    
    
    func configureImageViewCountry() {
        
        superview?.addSubview(imageViewCountry)
        
        let imageFrame = CGRect(origin: CGPoint(x: 11 + frame.minX, y: 10 + frame.minY), size: CGSize(width: 31, height: 31))
        imageViewCountry.frame = imageFrame
        
        let flag = Flag(countryCode: countryCode)
        let flagImage = flag?.image(style: .circle)
        imageViewCountry.image = flagImage
        
    }
    
    private func configureLabTitle() {
        
        superview!.addSubview(labTitle)
        
        let titleFrame = CGRect(x: 11 + frame.minX, y: -5 + frame.minY, width: bounds.width - 22, height: 9)
        labTitle.frame = titleFrame
        labTitle.text = "Страна"
        labTitle.adjustsFontSizeToFitWidth = true
        labTitle.sizeToFit()
        labTitle.backgroundColor = .white
        labTitle.font = UIFont(name: "PT Sans", size: 9)
        labTitle.textColor = #colorLiteral(red: 0.1134102717, green: 0.1596722603, blue: 0.4236576557, alpha: 1)
        labTitle.sizeToFit()
    }
    
    func configureLabCountry() {
        
        superview!.addSubview(labCountry)
        
        labCountry.frame = frame.inset(by: UIEdgeInsets(top: 13, left: 58, bottom: 13, right: 35))
        titleLabel?.alpha = 0
        labCountry.text = countryName
        labCountry.font = UIFont(name: "PTSans-Regular", size: 16)
        labCountry.textColor = #colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 1)
    }
    
    private func configureImageViewChevron() {
        
        superview!.addSubview(imageViewChevron)
        
        imageViewChevron.frame = frame.inset(by: UIEdgeInsets(top: 12, left: frame.width - 24 - 12, bottom: 12, right: 12))
        imageViewChevron.image = UIImage(named: "chevronRight")?.withRenderingMode(.alwaysTemplate)
        imageViewChevron.tintColor = #colorLiteral(red: 0.6007592082, green: 0.6064329147, blue: 0.6793243289, alpha: 1)
        
    }
    
    @objc private func tap() {
        print("Tap")
    }
    
}
