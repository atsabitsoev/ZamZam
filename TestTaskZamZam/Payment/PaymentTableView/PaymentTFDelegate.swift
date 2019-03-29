//
//  PaymentTFDelegate.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import AKMaskField

extension PaymentVC: AKMaskFieldDelegate {
    
    func maskFieldDidBeginEditing(_ maskField: AKMaskField) {
        let cell = tableView.cellForRow(at: [1,0]) as! CardDataCell
        var view = UIView()
        var lab = UILabel()
        switch maskField.tag {
        case 0:
            view = cell.viewCardNumber
            lab = cell.labTitleCardNumber
        case 1:
            view = cell.viewDate
            lab = cell.labDate
        case 2:
            view = cell.viewCVV
            lab = cell.labCVV
        case 3:
            view = cell.viewHolderOfCard
            lab = cell.labHolderOfCard
        default:
            print("error")
        }
        
        view.animateBorderColor(toColor: #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1), duration: 0.3)
        lab.alpha = 1
        lab.textColor = #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1)
        lab.layer.borderColor = #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1)
    }
    
    func maskFieldDidEndEditing(_ maskField: AKMaskField) {
        
        let cell = tableView.cellForRow(at: [1,0]) as! CardDataCell
        var view = UIView()
        var lab = UILabel()
        
        switch maskField.tag {
        case 0:
            view = cell.viewCardNumber
            lab = cell.labTitleCardNumber
        case 1:
            view = cell.viewDate
            lab = cell.labDate
        case 2:
            view = cell.viewCVV
            lab = cell.labCVV
        case 3:
            view = cell.viewHolderOfCard
            lab = cell.labHolderOfCard
        default:
            print("error")
        }
        
        if maskField.text != nil && maskField.text != "" {
            
            view.animateBorderColor(toColor: #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1), duration: 0.3)
            lab.alpha = 1
            lab.textColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            lab.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            
        } else {
            
            view.animateBorderColor(toColor: #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1), duration: 0.3)
            lab.alpha = 0
            print(lab.text!)
            lab.textColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            lab.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            
        }
        
    }
    
    func maskFieldShouldReturn(_ maskField: AKMaskField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
