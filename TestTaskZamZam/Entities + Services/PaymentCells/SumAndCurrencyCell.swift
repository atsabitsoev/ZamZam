//
//  SumAndCurrencyCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SumAndCurrencyCell: UITableViewCell {
    
    
    @IBOutlet weak var viewSum: UIView! {
        didSet {
            setBorder(to: viewSum)
        }
    }
    @IBOutlet weak var tfSum: UITextField!
    @IBOutlet weak var viewCurrency: UIView! {
        didSet {
            setBorder(to: viewCurrency)
        }
    }
    @IBOutlet weak var labCurrency: myLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func setBorder(to view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        view.layer.cornerRadius = 8
    }

}
