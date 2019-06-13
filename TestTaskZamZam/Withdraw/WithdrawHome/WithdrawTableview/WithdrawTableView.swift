//
//  TableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 13.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension WithdrawHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var mainCell = UITableViewCell()
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReplenishCell") as! ReplenishCell
            
            switch indexPath.section {
            case 0:
                
                cell.labTitle.text = "На карту любого банка"
                cell.labDescribtion.text = "180 стран мира"
                let im = UIImage(named: "creditCard")
                cell.imSmall.image = im?.withRenderingMode(.alwaysTemplate)
                
            case 1:
                
                cell.contentView.alpha = 0.5
                cell.isUserInteractionEnabled = false
                cell.labTitle.text = "Наличными у партнеров"
                cell.labDescribtion.text = "Любой оператор"
                let im = UIImage(named: "phoneIncoming")
                cell.imSmall.image = im?.withRenderingMode(.alwaysTemplate)
                
            case 2:
                
                cell.labTitle.text = "Наличными"
                cell.labDescribtion.text = "В любом отделении платежной системы CONTACT"
                let im = UIImage(named: "usersCopy")
                cell.imSmall.image = im?.withRenderingMode(.alwaysTemplate)
                
            default:
                print("error")
            }
            
            mainCell = cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReplenishDescribtionCell") as! ReplenishDescribtionCell
            
            var attributedString = NSMutableAttributedString()
            
            switch indexPath.section {
                
            case 0:
                print("\n")
                
//                attributedString = NSMutableAttributedString(string: "- Комиссия 1%",
//                                                             attributes: [
//                                                                .font: UIFont(name: "PTSans-Bold",
//                                                                              size: 10.0)!,
//                                                                .foregroundColor: UIColor(red: 10.0 / 255.0,
//                                                                                          green: 12.0 / 255.0,
//                                                                                          blue: 65.0 / 255.0,
//                                                                                          alpha: 1.0),
//                                                                .kern: 0.0
//                    ])
                
            default:
                
                print("Error")
                
            }
            
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            paragraphStyle.lineHeightMultiple = 0
            
            //            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            
            cell.label.attributedText = attributedString
            cell.label.numberOfLines = 0
            cell.label.layer.opacity = 0.8
            
            mainCell = cell
            
        }
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 68
        case 1:
            
            if indexPath.section == 0 {
                return 40
            } else {
                return 13
            }
            
        default:
            print("Error")
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let withdrawVC = UIStoryboard(name: "Withdraw", bundle: nil).instantiateViewController(withIdentifier: "WithdrawPaymentVC")
        self.navigationController?.show(withdrawVC, sender: nil)
    }
    
}
