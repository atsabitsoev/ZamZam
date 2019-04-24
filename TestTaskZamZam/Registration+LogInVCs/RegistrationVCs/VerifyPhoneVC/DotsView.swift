//
//  DotsView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 24/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

@IBDesignable
class DotsView: UIView {
    
    
    @IBInspectable var totalDots: Int = 6 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var solidDots: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var showableCode: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var fontName: String = "KelsonSans-RegularRU"
    private var betweenCenters: CGFloat = 30
    private var radius: CGFloat = 8
    
    @IBInspectable var color: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
    
    var masLabels: [myLabel] = []
    

    override func draw(_ rect: CGRect) {
        removeLabels()
        
        let centers = getCenterPoints()
        drawDotsOrLabels(in: centers)
        
        addLabels()
    }
    
    
    private func addLabels() {
        for lab in masLabels {
            self.addSubview(lab)
        }
    }
    
    private func removeLabels() {
        for lab in masLabels {
            lab.alpha = 0
        }
    }
    
    private func drawDotsOrLabels(in centers: [CGPoint]) {
        var i = 0
        for center in centers {
            if i < solidDots || i < showableCode.count {
                
                if showableCode == "" {
                    drawDot(in: center, solid: true)
                } else {
                    setLabel(text: showableCode[String.Index(encodedOffset: i)], center: center, i: i)
                }
                
            } else {
                drawDot(in: center, solid: false)
            }
            
            i += 1
        }
        print(centers)
    }
    
    private func drawDot(in center: CGPoint, solid: Bool) {
        let roundPath  = UIBezierPath(ovalIn: CGRect(x: center.x - radius,
                                                     y: center.y - radius,
                                                     width: radius * 2,
                                                     height: radius * 2))
        if solid {
            color.setFill()
            roundPath.fill()
        } else {
            color.setStroke()
            roundPath.lineWidth = 1
            roundPath.stroke()
        }
    }
    
    private func setLabel(text: Character, center: CGPoint, i: Int) {
        
        let label = myLabel()
        label.bounds.size = CGSize(width: 16, height: 35)
        label.text = String(text)
        label.font = UIFont(name: fontName, size: 30)
        label.textAlignment = .center
        label.center = center
        label.textColor = #colorLiteral(red: 0.1074947491, green: 0.1614276171, blue: 0.4236208797, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        masLabels.append(label)
    }
    
    private func getCenterPoints() -> [CGPoint] {
        
        var centers = [CGPoint]()
        
        for i in 0..<totalDots {
            var multiplier: CGFloat = 0
            multiplier = CGFloat(i - (totalDots - 1) / 2)
            if totalDots % 2 == 0 {
                multiplier -= 0.5
            }
            print(multiplier)
            let centerX: CGFloat = self.center.x + CGFloat(multiplier * betweenCenters)
            let centerY: CGFloat = self.center.y
            let centerPoint = CGPoint(x: centerX - self.frame.minX,
                                      y: centerY - self.frame.minY)
            centers.append(centerPoint)
        }
        
        return centers
    }
}
