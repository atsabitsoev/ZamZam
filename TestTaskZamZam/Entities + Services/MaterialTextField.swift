//
//  ZamTextField.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit



class MaterialTextField: UITextField {
    
    
    @IBInspectable var inActiveColor: UIColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
    @IBInspectable var activeColor: UIColor = #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1)
    @IBInspectable var title: String = "Заголовок"
    
    
    var padding = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 5)
    
    
    private lazy var labTitle: MaterialTextFieldLabTitle = MaterialTextFieldLabTitle()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 8
        layer.borderWidth = 2
        labTitle.isHidden = true
        
        layer.borderColor = inActiveColor.cgColor
        
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLabTitle()
        
        layoutIfNeeded()
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
    
    
    func configureLabTitle() {
        
        superview!.addSubview(labTitle)
        
        let titleFrame = CGRect(x: 11 + frame.minX, y: -5 + frame.minY, width: bounds.width - 22, height: 9)
        labTitle.frame = titleFrame
        labTitle.text = title
        labTitle.adjustsFontSizeToFitWidth = true
        labTitle.sizeToFit()
        labTitle.backgroundColor = .white
        labTitle.font = UIFont(name: "PT Sans", size: 9)
        labTitle.textColor = isEditing ? activeColor : inActiveColor
        
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    
}


class MaterialTextFieldLabTitle: UILabel {
    
    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        super.drawText(in: newRect)
    }
}
