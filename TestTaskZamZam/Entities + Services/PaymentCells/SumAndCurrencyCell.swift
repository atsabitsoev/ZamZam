//
//  SumAndCurrencyCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SumAndCurrencyCell: UITableViewCell, UITextFieldDelegate {
    
    
    var paymentNewVC: PaymentNewVC?
    var interTransPaymentVC: InterTransPaymentVC?
    var replenishVC: ReplenishNewVC?
    
    
    @IBOutlet weak var viewSum: UIView! {
        didSet {
            //setBorder(to: viewSum)
        }
    }
    @IBOutlet weak var tfSum: UITextField! {
        didSet {
            tfSum.delegate = self
        }
    }
    @IBOutlet weak var viewCurrency: CurrencySelectView!
    
    
    private func setBorder(to view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        view.layer.cornerRadius = 8
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func sumTextChanged(_ sender: UITextField) {
        
        if let paymentNewVC = self.paymentNewVC {
            paymentNewVC.transferList["sum"] = tfSum.text
            paymentNewVC.tableView.reloadData()
        } else if let interTransPaymentVC = self.interTransPaymentVC {
            interTransPaymentVC.transferList["sum"] = tfSum.text
            interTransPaymentVC.tableView.reloadData()
        } else if let replenishVC = self.replenishVC {
            replenishVC.transferList["sum"] = tfSum.text
            replenishVC.tableView.reloadData()
        }
    }
    
}
