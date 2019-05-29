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
    
    
    @IBInspectable var thisUserColor: UIColor = #colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 1)
    @IBInspectable var anotherUserColor: UIColor = #colorLiteral(red: 0.5019607843, green: 0.9215686275, blue: 0.4549019608, alpha: 1)
    
    
    var direction: TransferDirection = .out
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setColorsToViews()
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureViews()
        
        layoutIfNeeded()
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
        addSubview(viewFront)
    }
    
    
    private func configureViews() {
        
        roundViews([viewFront, viewBack])
        setBoundsToViews()
    }
    
    private func roundViews(_ views: [UIView]) {
        
        for view in views {
            
            view.layer.cornerRadius = view.bounds.height / 2
            view.clipsToBounds = true
        }
    }
    
    private func setBoundsToViews() {
        
        viewBack.frame = CGRect(x: frame.height / 2,
                                y: frame.height / 2,
                                width: frame.height,
                                height: frame.height)
        viewFront.frame = CGRect(x: -frame.height / 2,
                                 y: frame.height / 2,
                                 width: frame.height,
                                 height: frame.height)
    }
    
    
}


enum TransferDirection {
    
    case into, out
}
