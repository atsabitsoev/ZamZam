//
//  CardDataCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import AKMaskField

class CardDataCell: UITableViewCell {
    
    @IBOutlet weak var viewGrayMain: UIView!
    @IBOutlet weak var viewCardNumber: UIView!
    @IBOutlet weak var tfCardNumber: AKMaskField!
    @IBOutlet weak var labTitleCardNumber: myLabel!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var tfDate: AKMaskField!
    @IBOutlet weak var labDate: myLabel!
    @IBOutlet weak var viewCVV: UIView!
    @IBOutlet weak var tfCVV: AKMaskField!
    @IBOutlet weak var labCVV: myLabel!
    @IBOutlet weak var imCheck: UIImageView! {
        didSet {
            imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    
    lazy var textFields: [AKMaskField] = [tfDate, tfCardNumber, tfCVV]
    
    
    override func layoutSubviews() {
        viewGrayMain.layer.cornerRadius = 8
        let whiteViews = [viewCardNumber, viewDate, viewCVV]
        for view in whiteViews {
            view?.layer.cornerRadius = 8
            view?.layer.borderWidth = 2
            view?.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        }
        
        let titles = [labTitleCardNumber, labCVV, labDate]
        for title in titles {
            title?.alpha = 0
            title?.layer.cornerRadius = 2
        }
    }

}
