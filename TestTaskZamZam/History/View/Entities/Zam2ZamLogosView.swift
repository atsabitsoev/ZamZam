//
//  Zam2ZamLogosView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


class Zam2ZamLogosView: UIView {
    
    
    private let viewBack: UIView = UIView()
    private let viewFront: UIView = UIView()
    private let imageZamLogo1: UIImageView = UIImageView()
    private let imageZamLogo2: UIImageView = UIImageView()
    
    
    @IBInspectable var thisUserColor: UIColor = #colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 1)
    @IBInspectable var anotherUserColor: UIColor = #colorLiteral(red: 0.5019607843, green: 0.9215686275, blue: 0.4549019608, alpha: 1)
    
    
    var direction: TransferDirection = .out {
        didSet {
            setColorsToViews()
            setNeedsDisplay()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubviews()
        setImages()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        configureViews()
        setColorsToViews()
        
        configureImageViews()
    }
    
    
    private func setColorsToViews() {
        
        switch direction {
        case .out:
            viewBack.backgroundColor = thisUserColor
            viewFront.backgroundColor = anotherUserColor
        case .into:
            viewBack.backgroundColor = anotherUserColor
            viewFront.backgroundColor = thisUserColor
        }
    }
    
    private func addSubviews() {
        
        addSubview(viewBack)
       // addSubview(viewFront)
        viewBack.addSubview(imageZamLogo1)
        viewFront.addSubview(imageZamLogo2)
    }
    
    
    private func configureViews() {
        
        setBoundsToViews()
        roundViews([viewFront, viewBack])
    }
    
    private func roundViews(_ views: [UIView]) {
        
        for view in views {
            
            view.layer.cornerRadius = view.bounds.height / 2
            view.clipsToBounds = true
        }
    }
    
    private func setBoundsToViews() {
        
        viewBack.frame = CGRect(x: 0,
                                y: 0,
                                width: frame.height,
                                height: frame.height)
        viewFront.frame = CGRect(x: frame.width - frame.height,
                                 y: 0,
                                 width: frame.height,
                                 height: frame.height)
    }
    
    
    private func configureImageViews() {
        
        imageZamLogo1.frame = viewBack.bounds.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        imageZamLogo2.frame = viewFront.bounds.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    private func setImages() {
        
        let zamLogo: UIImage = UIImage(named: "logo")!
        
        imageZamLogo1.image = zamLogo
        imageZamLogo2.image = zamLogo
    }
    
    
}


enum TransferDirection {
    
    case into, out
}
