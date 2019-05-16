//
//  PaymentNewTableVIew.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension PaymentNewVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberSenderCellPhoneNumberCells = 1
        let numberBillCells = masZamBills.count
        let sumAndCurrencyCells = 1
        let totalInfoCells = 1
        let butNextCells = 1
        
        switch section {
        case 0:
            return numberSenderCellPhoneNumberCells
        case 1:
            return numberBillCells
        case 2:
            return sumAndCurrencyCells
        case 3:
            return totalInfoCells
        case 4:
            return butNextCells
        default:
            print("Error")
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
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return (UIScreen.main.bounds.width - 36) * (16/113) + 10
        case 1:
            return 80
        case 2:
            return (UIScreen.main.bounds.width - 36) * (16/113) + 10
        case 3:
            return 150
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //1
        let viewFor1Section = UIView(frame: tableView.rectForHeader(inSection: section))
        viewFor1Section.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        let label = myLabel(frame: viewFor1Section.bounds.inset(by: UIEdgeInsets(top: 13, left: 18, bottom: 7, right: 18)))
        label.text = "Выберете способ оплаты"
        label.textColor = #colorLiteral(red: 0.08931172639, green: 0.1388869584, blue: 0.3626311421, alpha: 1)
        label.font = UIFont(name: "KelsonSans-RegularRU", size: 14)
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
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBill") as! BillCell
            let currency = CurrencyManager.getCurrency(byType: masZamBills[indexPath.row].currency)
            cell.labName.text = "Zam счет \(currency.shortName)"
            cell.labSum.text = "\(masZamBills[indexPath.row].sum) \(currency.symbol)"
            cell.labValuta.text = currency.symbol
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SumAndCurrencyCell") as! SumAndCurrencyCell
            return cell
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalInfoCell") as! TotalInfoCell
            return cell
            
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonNextCell") as! ButtonNextCell
            return cell
            
        default:
            
            print("error")
            return UITableViewCell()
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? ButtonNextCell else { return }
        cell.configureButNext()
        
    }
    
    
}
