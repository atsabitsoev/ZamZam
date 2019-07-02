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
    var withdrawVC: WithdrawPaymentVC?
    
    
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
    
    
    override func awakeFromNib() {
        viewCurrency.currencies = [CurrencyRubble()]
    }


    private func formatSumText() {
        print("hello world")

        guard let sumDouble = Double(tfSum.text!.withoutSpaces()) else { return }
        let formattedString = sumDouble.formattedWithSeparator
        print(formattedString)
        tfSum.text = formattedString
    }
    

    //Text field delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard string != "" else { return true }
        let numbers: Set = ["1","2","3","4","5","6","7","8","9","0",","]
        guard numbers.contains(string) else { return false }
        guard textField.text!.count < 9 else { return false }

        if textField.text!.contains(",") {

            let indexOfComma = textField.text!.firstIndex(of: ",")?.utf16Offset(in: textField.text!)
            if textField.text!.count < indexOfComma! + 3 {
                return true
            } else {
                return false
            }
        }

        return true
    }
    
    
    @IBAction func sumTextChanged(_ sender: UITextField) {

        if let paymentNewVC = self.paymentNewVC {

            paymentNewVC.transferList["sum"] = tfSum.text!.withoutSpaces().replaceCommasToDots()
            UIView.setAnimationsEnabled(false)
            paymentNewVC.tableView.reloadSections([4], with: .none)
            UIView.setAnimationsEnabled(true)

        } else if let interTransPaymentVC = self.interTransPaymentVC {

            interTransPaymentVC.transferList["sum"] = tfSum.text!.withoutSpaces().replaceCommasToDots()
            UIView.setAnimationsEnabled(false)
            interTransPaymentVC.tableView.reloadSections([4], with: .none)
            UIView.setAnimationsEnabled(true)

        } else if let replenishVC = self.replenishVC {

            replenishVC.transferList["sum"] = tfSum.text!.withoutSpaces().replaceCommasToDots()
            UIView.setAnimationsEnabled(false)
            replenishVC.tableView.reloadSections([4], with: .none)
            UIView.setAnimationsEnabled(true)

        } else if let withdrawVC = self.withdrawVC {

            withdrawVC.transferList["sum"] = tfSum.text!.withoutSpaces().replaceCommasToDots()
            UIView.setAnimationsEnabled(false)
            withdrawVC.tableView.reloadSections([4], with: .none)
            UIView.setAnimationsEnabled(true)

        }

        formatSumText()
    }
    
}
