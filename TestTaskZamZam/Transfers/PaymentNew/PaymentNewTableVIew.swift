//
//  PaymentNewTableVIew.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import FlagKit

extension PaymentNewVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberSenderCellPhoneNumberCells = 1
        let numberBillCells = masZamBills.count
        let numberCards = cards.count
        let sumAndCurrencyCells = 1
        let totalInfoCells = 1
        
        switch section {
        case 0:
            return numberSenderCellPhoneNumberCells
        case 1:
            return numberBillCells + numberCards
        case 2:
            return 1
        case 3:
            return sumAndCurrencyCells
        case 4:
            return totalInfoCells
        default:
            print("\(section)")
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 30
        case 1:
            return 37
        case 2:
            return 0
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return (UIScreen.main.bounds.width - 36) * (16/113) + 10
        case 1:
            if indexPath.row >= masZamBills.count {
                return 70
            }
            return 84
        case 2:
            if newCardAdding {
                return 158
            } else {
                return 48
            }
        case 3:
            return 80 //(UIScreen.main.bounds.width - 36) * (16/113) + 10
        case 4:
            return 54
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //1
        let viewFor1Section = UIView(frame: tableView.rectForHeader(inSection: section))
        viewFor1Section.backgroundColor = .clear
        let label = myLabel(frame: viewFor1Section.bounds.inset(by: UIEdgeInsets(top: 9, left: 18, bottom: 7, right: 18)))
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.text = "Выберите способ оплаты"
        label.textColor = #colorLiteral(red: 0.08931172639, green: 0.1388869584, blue: 0.3626311421, alpha: 1)
        label.font = UIFont(name: "PTSans-Bold", size: 15)
        viewFor1Section.addSubview(label)
        //Any
        let viewForAnySection = UIView(frame: tableView.rectForHeader(inSection: section))
        
        switch section {
        case 1:
            return viewFor1Section
        default:
            return viewForAnySection
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCellPhoneNumber") as! SenderCellPhoneNumber
            
            cell.butContacts.addTarget(self,
                                       action: #selector(openContacts),
                                       for: .touchUpInside)
            cell.tfPhoneNumber.text = transferList["phone"]
            cell.imCountry.image = Flag(countryCode: Locale.current.regionCode!)?.image(style: .circle)
            cell.tfPhoneNumber.addTarget(self,
                                         action: #selector(checkFill),
                                         for: .editingChanged)
            
            return cell
            
        case 1:
            
            if indexPath.row >= masZamBills.count {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CardCellNewPayment") as! CardCellNewPayment
                
                if let index = self.selectedCardIndex, index == indexPath.row - masZamBills.count {
                    cell.addCheck()
                } else {
                    cell.deleteCheck()
                }
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBill") as! ZamBillCheckCell
            let bill = masZamBills[indexPath.row]
            
            cell.labName.text = "ZAM счет \(bill.currency.shortName)"
            cell.labSum.text = "\(bill.sum.formattedWithSeparator) \(bill.currency.symbol)"
            cell.labCurrency.text = bill.currency.symbol
            
            if bill.currency.shortName == transferList["senderCurrency"]! {
                cell.addCheck()
            } else {
                cell.deleteCheck()
            }
            
            return cell
            
        case 2:
            
            if newCardAdding {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CardDataCell") as! CardDataCell
                for tf in cell.textFields {
                    tf.maskDelegate = self
                }
                // TAGS OF TFs
                
                cell.tfCardNumber.tag = 0
                cell.tfDate.tag = 1
                cell.tfCVV.tag = 2
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewCardCell") as! AddNewCardCell
                return cell
            }
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SumAndCurrencyCell") as! SumAndCurrencyCell
            cell.paymentNewVC = self
            cell.viewCurrency.delegate = self

            cell.tfSum.addTarget(self,
                                 action: #selector(checkFill),
                                 for: .editingChanged)

            return cell
            
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalInfoCell") as! TotalInfoCell
            cell.labSum.text = transferList["sum"] == "" ? "0 ₽" : "\(self.transferList["sum"]!) ₽"
            return cell
            
        default:
            
            print("error")
            return UITableViewCell()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
        
            if indexPath.row < masZamBills.count {
                self.zamBillSelected(indexPath.row)
            } else {
                self.cardBillSelected(indexPath.row - masZamBills.count)
            }
            
        } else if indexPath.section == 2 {
            
            self.newCardAddingSelected()
            
        }
    }
    
    
}
