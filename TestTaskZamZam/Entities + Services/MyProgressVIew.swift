//
//  MyProgressVIew.swift
//  TestTaskZamZam
//
//  Created by Iliya B on 04/07/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

@IBDesignable
class MyProgressVIew: UIView {


    @IBInspectable var progress: Float = 0
    @IBInspectable var backColor: UIColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
    @IBInspectable var progressColor: UIColor = #colorLiteral(red: 0.5019607843, green: 0.9215686275, blue: 0.4549019608, alpha: 1)
    @IBInspectable var cornerRadius: Float = 4


    override func draw(_ rect: CGRect) {

        setBackground(rect: rect)
        setProgress(rect: rect)
    }


    private func setBackground(rect: CGRect) {

        let path = UIBezierPath(roundedRect: rect,
                                cornerRadius: CGFloat(cornerRadius))
        backColor.setFill()
        path.fill()
    }

    private func setProgress(rect: CGRect) {

        let progressWidth = rect.width * CGFloat(progress)
        let insets = UIEdgeInsets(top: 0,
                                  left: 0,
                                  bottom: 0,
                                  right: rect.width - progressWidth)
        let progressRect = rect.inset(by: insets)

        let path = UIBezierPath(roundedRect: progressRect,
                                cornerRadius: 4)
        progressColor.setFill()
        path.fill()
    }

}
