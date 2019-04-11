//
//  PaymentTableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import AKMaskField

extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if cardAdding {
                return cards.count + 1
            } else {
                return cards.count + 2
            }
            
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if cardAdding {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 71
        case 1:
            
            if cardAdding {
                return 205
            } else {
                return 150
            }
            
        case 2:
            
            return 150
            
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            
            if indexPath.row == 0 {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "ZamBillCell") as! ZamBillCell
                
            } else if indexPath.row == cards.count + 1 {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "AddNewCardCell") as! AddNewCardCell
                
            } else {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardCell
                
            }
            
        case 1:
            
            if cardAdding {
                
                let myCell = tableView.dequeueReusableCell(withIdentifier: "CardDataCell") as! CardDataCell
                
                for tf in myCell.textFields {
                    tf.maskDelegate = self
                }
                // TAGS OF TFs
                
                myCell.tfCardNumber.tag = 0
                myCell.tfDate.tag = 1
                myCell.tfCVV.tag = 2
                myCell.tfHolderOfCard.tag = 3
                
                cell = myCell
                
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "TotalInfoCell") as! TotalInfoCell
            }
            
        case 2:
            
            cell = tableView.dequeueReusableCell(withIdentifier: "TotalInfoCell") as! TotalInfoCell
            
        default:
            print("error")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 && tableView.numberOfRows(inSection: 0) == cards.count + 2 {
            if cardAdding {
                return
            }
            
            if indexPath.section > 0 {
                print("Выделена ненужная ячейка")
            }
            
            cardAdding = true
            tableView.beginUpdates()
            tableView.deleteRows(at: [[0,cards.count + 1]], with: .fade)
            tableView.insertSections([1], with: .fade)
            tableView.endUpdates()
            
        } else if cardAdding {
            
            cardAdding = false
            tableView.beginUpdates()
            tableView.insertRows(at: [[0,cards.count + 1]], with: .fade)
            tableView.deleteSections([1], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section > 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height = CGFloat()
        
        switch section {
        case 0:
            height = 47
        case 1:

            height = 0.001

        case 2:

            height = 0.001

        default:

            height = 0.001
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.001
        case 1:
            if tableView.numberOfSections == 2 {
                return 36
            } else {
                return 0.001
            }
        case 2:
            return 36
        default:
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view = UIView()
        let font = UIFont(name: "KelsonSans-RegularRU",
                          size: 14)!
        
        switch section {
        case 0:
            
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 47))
            
            let label = UILabel(frame: CGRect(x: 21, y: 22, width: tableView.bounds.width, height: 15))
            let attributedString = NSMutableAttributedString(string: "Выберите способ оплаты",
                                                             attributes: [NSAttributedString.Key.font : font,
                                                                          NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)])
            label.attributedText = attributedString
            myView.addSubview(label)
            
            view = myView
            
//        case 1:
//            if !(tableView.numberOfSections == 2) {
//
//                let myView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 54))
//
//                let label = UILabel(frame: CGRect(x: 18, y: 39, width: tableView.bounds.width, height: 15))
//                let attributedString = NSMutableAttributedString(string: "Данные карты отправителя",
//                                                                 attributes: [NSAttributedString.Key.font : font,
//                                                                              NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)])
//                label.attributedText = attributedString
//                myView.addSubview(label)
//
//                view = myView
//
//            }
            
        case 2:
            return view
        default:
            return view
        }
        
        return view
        
    }
    
}
