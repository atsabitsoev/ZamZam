//
//  SumAndCurrencyCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SumAndCurrencyCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var viewSum: UIView! {
        didSet {
            setBorder(to: viewSum)
        }
    }
    @IBOutlet weak var tfSum: UITextField! {
        didSet {
            tfSum.delegate = self
        }
    }
    @IBOutlet weak var viewCurrency: UIView! {
        didSet {
            configureViewCurrency()
        }
    }
    @IBOutlet weak var labCurrency: myLabel!
    

    private func configureViewCurrency() {
        
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(ViewCurrencyTapped))
        viewCurrency.addGestureRecognizer(gestureRec)
        
        setBorder(to: viewCurrency)
        
    }
    
    @objc private func ViewCurrencyTapped() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewCurrencyTapped"), object: nil)
        
    }
    
    
    private func setBorder(to view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        view.layer.cornerRadius = 8
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
