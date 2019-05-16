//
//  PayPhoneBillTableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension PayPhoneBillVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return masZamBills!.count + masCardBills!.count + 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCellPhoneNumber") as! SenderCellPhoneNumber
                return cell
                
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCellField") as! SenderCellField
                return cell
                
            default:
                return UITableViewCell()
            }
            
        case 1:
            
            if indexPath.row < masZamBills!.count {
                print("Вторая")
                // СЧЕТА ЗАМ
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZamBillCell") as! ZamBillCell
                
                let currencyType = masZamBills![indexPath.row].currencyType
                let currencyShort = CurrencyManager.getCurrency(byType: currencyType).shortName
                cell.labBillKind.text = "Zam счет \(currencyShort)"
                
                cell.labBillSum.text = String(masZamBills![indexPath.row].sum)
                return cell
                
            } else if indexPath.row < masZamBills!.count + masCardBills!.count {
                
                // СЧЕТА КАРТ
                let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardCell
                let index = indexPath.row - masZamBills!.count
                
                let first4numbers = masCardBills![index].first4Numbers
                let last4numbers = masCardBills![index].last4numbers
                let cardNumber = "\(first4numbers) **** **** \(last4numbers)"
                cell.labCardNumber.text = cardNumber
                
                return cell
                
            } else {
                
                // ЯЧЕЙКА ДОБАВЛЕНИЯ КАРТЫ
                if cardAdding {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CardDataCell") as! CardDataCell
                    
                    for tf in cell.textFields {
                        tf.maskDelegate = self
                    }
                    // TAGS OF TFs
                    
                    cell.tfCardNumber.tag = 0
                    cell.tfDate.tag = 1
                    cell.tfCVV.tag = 2
                    cell.tfHolderOfCard.tag = 3
                    
                    return cell
                } else {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewCardCell") as! AddNewCardCell
                    
                    return cell
                }
                
            }
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PayPhoneInfoCell") as! PayPhoneInfoCell
            
            return cell
            
        default:
            
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 65
        case 1:
            if indexPath.row == masZamBills!.count + masCardBills!.count {
                if cardAdding {
                    return 205
                } else {
                    return 71
                }
            } else {
                return 71
            }
        case 2:
            return 150
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == tableView.numberOfRows(inSection: 1) - 1 {
            
            if cardAdding {
                return
            } else {
                cardAdding = true
                tableView.beginUpdates()
                tableView.deleteRows(at: [[1,tableView.numberOfRows(inSection: 1) - 1]], with: .fade)
                tableView.insertRows(at: [[1,tableView.numberOfRows(inSection: 1) - 1]], with: .fade)
                tableView.endUpdates()
            }
        } else if cardAdding {
            cardAdding = false
            tableView.beginUpdates()
            tableView.insertRows(at: [[1,tableView.numberOfRows(inSection: 1) - 1]], with: .fade)
            tableView.deleteRows(at: [[1,tableView.numberOfRows(inSection: 1) - 1]], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return 28
            
        } else if section == 1 {
            
            return 55
            
        } else {
            
            return 22
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView(frame: tableView.rectForHeader(inSection: 1))
            let label = myLabel(frame: CGRect(x: 21,
                                              y: 23,
                                              width: UIScreen.main.bounds.width - 21 - 20,
                                              height: 15))
            label.text = "Выберите счет или карту с которого хотите оплатить"
            label.font = UIFont(name: "KelsonSans-RegularRU", size: 14)
            label.numberOfLines = 0
            label.textColor = #colorLiteral(red: 0.1055305973, green: 0.1625663936, blue: 0.4235753119, alpha: 1)
            label.adjustsFontSizeToFitWidth = true
            
            view.addSubview(label)
            return view
            
        } else {
            return UIView()
        }
    }
    
    
}
