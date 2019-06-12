//
//  TableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 13.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension TransfersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var mainCell = UITableViewCell()
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "transfersCell") as! TransCell
            
            switch indexPath.section {
            case 0:
                
                cell.labTitle.text = "Переводы за рубеж"
                cell.labDescribtion.text = "180 стран мира"
                let im = UIImage(named: "globe")
                cell.imSmall.image = im?.withRenderingMode(.alwaysTemplate)
                
            case 1:
                
                cell.labTitle.text = "Со счета на счет ZAM"
                cell.labDescribtion.text = "По номеру телефона"
                let im = UIImage(named: "repeat")
                cell.imSmall.image = im?.withRenderingMode(.alwaysTemplate)
                
            default:
                print("error")
            }
            
            mainCell = cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "transferDescribtionCell") as! TransDescribtionCell
            
            var attributedString = NSMutableAttributedString()
            
            switch indexPath.section {
                
            case 0:
                
                attributedString = NSMutableAttributedString(string: "- Комиссия 0% за валютные переводы\n- Кэшбэк 1% от суммы перевода \n- Оплачивайте перевод картой любого банка\n- Получить перевод можно в одной из 3000 точек обслуживания",
                                                             attributes: [
                                                                .font: UIFont(name: "PT Sans",
                                                                              size: 10.0)!,
                                                                .foregroundColor: UIColor(red: 10.0 / 255.0,
                                                                                          green: 12.0 / 255.0,
                                                                                          blue: 65.0 / 255.0,
                                                                                          alpha: 1.0),
                                                                .kern: 0.0
                    ])
                attributedString.addAttribute(.font,
                                              value: UIFont(name: "PT Sans",
                                                            size: 10.0)!, range: NSRange(location: 0,
                                                                                         length: 13))
                attributedString.addAttribute(.font,
                                              value: UIFont(name: "PT Sans",
                                                            size: 10.0)!,
                                              range: NSRange(location: 35,
                                                             length: 11))
                attributedString.addAttribute(.foregroundColor, value: UIColor(red: 86/255,
                                                                               green: 192/255,
                                                                               blue: 253/255,
                                                                               alpha: 1),
                                              range: NSRange(location: 149,
                                                             length: 18))
                
            case 1:
                
                attributedString = NSMutableAttributedString(string: "- Комиссия 0%\n- Переводите по номеру телефона\n- Оплачивайте перевод картой любого банка\n- Получить перевод можно в одной из 3000 точек обслуживания",
                                                                 attributes: [
                    .font: UIFont(name: "KelsonSans-RegularRU",
                                  size: 10.0)!,
                    .foregroundColor: UIColor(red: 10.0 / 255.0,
                                              green: 12.0 / 255.0,
                                              blue: 65.0 / 255.0,
                                              alpha: 1.0),
                    .kern: 0.0
                    ])
                attributedString.addAttribute(.font,
                                              value: UIFont(name: "PT Sans",
                                                            size: 10.0)!,
                                              range: NSRange(location: 0,
                                                             length: 15))
                attributedString.addAttribute(.foregroundColor,
                                              value: UIColor(red: 86/255,
                                                             green: 192/255,
                                                             blue: 253/255,
                                                             alpha: 1),
                                              range: NSRange(location: 129,
                                                             length: 18))
                
            default:
                
                print("Error")
                
            }
            
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            paragraphStyle.lineHeightMultiple = 0
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            
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
            return 119
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
        switch indexPath {
        case [0,0]:
            // Переводы за рубеж
            let whatCountryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "whatCountryVC") as! WhatCountryVC
            whatCountryVC.nextVCIsInterTransReciverVC = true
            self.navigationController?.show(whatCountryVC, sender: nil)
            print("Переводы  за рубеж")
        case [1,0]:
            // Открыть экран перевода с счета замзам
            let transferZamZamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentNewVC")
            self.navigationController?.show(transferZamZamVC, sender: nil)
        default:
            print("error")
        }
    }
    
}
