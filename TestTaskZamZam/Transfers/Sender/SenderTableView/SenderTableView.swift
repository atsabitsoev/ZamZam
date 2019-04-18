//
//  SenderTableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension SenderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2,3:
            return 3
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath {
        case [0,0]:
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "SenderCellPhoneNumber") as! SenderCellPhoneNumber
            
            myCell.viewWhite.layer.cornerRadius = 8
            myCell.viewWhite.layer.borderWidth = 2
            myCell.viewWhite.layer.borderColor = #colorLiteral(red: 0.7131326199, green: 0.7154058814, blue: 0.7812535763, alpha: 1)
            
            cell = myCell
            
        case [2,0]:
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "SenderCellCountry") as! SenderCellCountry
            
            myCell.viewWhite.layer.cornerRadius = 8
            myCell.viewWhite.layer.borderWidth = 2
            myCell.viewWhite.layer.borderColor = #colorLiteral(red: 0.7131326199, green: 0.7154058814, blue: 0.7812535763, alpha: 1)
            
            cell = myCell
            
        default:
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "SenderCellField") as! SenderCellField
            
            myCell.viewWhite.layer.cornerRadius = 8
            myCell.viewWhite.layer.borderWidth = 2
            myCell.viewWhite.layer.borderColor = #colorLiteral(red: 0.7131326199, green: 0.7154058814, blue: 0.7812535763, alpha: 1)
            
            let placeholderText = masFieldTitles[indexPath.section][indexPath.row]
            myCell.textField.placeholder = placeholderText
            myCell.labTitle.text = placeholderText
            myCell.textField.delegate = self
            
            myCell.textField.tag = indexPath.section * 1000 + indexPath.row
            myCell.textField.text = dictUserData[myCell.textField.tag]
            
            if myCell.textField.text != nil && myCell.textField.text != "" {
                
                myCell.labTitle.textColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
                myCell.labTitle.alpha = 1
                myCell.viewWhite.layer.borderColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
                
            } else {
                
                myCell.labTitle.alpha = 0
                myCell.viewWhite.layer.borderColor = #colorLiteral(red: 0.7131326199, green: 0.7154058814, blue: 0.7812535763, alpha: 1)
                
            }
            
            cell = myCell
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 47
        case 1,2:
            return 34
        default:
            return 78
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: tableView.bounds.width,
                                        height: 30))
        let label = UILabel(frame: CGRect(x: 18,
                                          y: 0,
                                          width: tableView.bounds.width,
                                          height: 15))
        let myString = NSMutableAttributedString(string: self.masSectionNames[section],
                                                 attributes: [NSAttributedString.Key.font : UIFont(name: "KelsonSans-RegularRU",
                                                                                                   size: 14)!,
                                                              NSAttributedString.Key.foregroundColor: UIColor(red: 30/255,
                                                                                                              green: 41/255,
                                                                                                              blue: 104/255,
                                                                                                              alpha: 1)])
        label.attributedText = myString
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: tableView.bounds.width,
                                            height: 47))
            
            let label = UILabel(frame: CGRect(x: 28,
                                              y: 6,
                                              width: tableView.bounds.width - 56,
                                              height: 15))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let myString = NSMutableAttributedString(string: "На этот номер будет отправлено уведомление.",
                                                     attributes: [NSAttributedString.Key.font : UIFont(name: "KelsonSans-RegularRU",
                                                                                                       size: 12)!,
                                                                  NSAttributedString.Key.foregroundColor: UIColor(red: 167/255,
                                                                                                                  green: 167/255,
                                                                                                                  blue: 187/255,
                                                                                                                  alpha: 1),
                                                                  NSAttributedString.Key.paragraphStyle: paragraphStyle])
            label.attributedText = myString
            
            view.addSubview(label)
            return view
            
        } else if section == 3 {
            
            let view = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: tableView.bounds.width,
                                            height: 47))
            
            let label = UILabel(frame: CGRect(x: 21,
                                              y: 30,
                                              width: tableView.bounds.width - 42,
                                              height: 48))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let myString = NSMutableAttributedString(string: "Данные должны полностью совпадать с документом. Обязательно перепроверьте данные перед отправкой.",
                                                     attributes: [NSAttributedString.Key.font : UIFont(name: "KelsonSans-RegularRU",
                                                                                                       size: 12)!,
                                                                  NSAttributedString.Key.foregroundColor: UIColor(red: 167/255,
                                                                                                                  green: 167/255,
                                                                                                                  blue: 187/255,
                                                                                                                  alpha: 1),
                                                                  NSAttributedString.Key.paragraphStyle: paragraphStyle])
            label.numberOfLines = 0
            label.attributedText = myString
            view.addSubview(label)
            
            return view
            
        } else {
            
            return UIView()
            
        }
        
    }
    
}
