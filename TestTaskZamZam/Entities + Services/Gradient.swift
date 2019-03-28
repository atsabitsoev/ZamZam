//
//  Gradient.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension UIView {
    
    func addGradient(colors: [CGColor], coordinatesX: [Int], coordinatesY:[Int], cornerRadius: CGFloat = 0) {
        if self.layer.sublayers == nil {
            return
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: coordinatesX[0], y: coordinatesY[0])
        gradient.endPoint = CGPoint(x: coordinatesX[1], y: coordinatesY[1])
        gradient.cornerRadius = cornerRadius
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
