//
//  myLabel.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class myLabel: UILabel{
    
    override func drawText(in rect: CGRect) {
        
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: bounds.height/10, left: 0, bottom: 0, right: 0)))
    }
    
}
