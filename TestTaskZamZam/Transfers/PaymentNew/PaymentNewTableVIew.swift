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
            return 20
        case 1:
            return 30
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //0
        let viewForAnySection = UIView(frame: tableView.rectForHeader(inSection: section))
        //1
        let viewFor1Section = UIView(frame: tableView.rectForHeader(inSection: section))
        let label = myLabel(frame: viewFor1Section.bounds.inset(by: UIEdgeInsets(top: 10, left: 18, bottom: 7, right: 18)))
        label.text = "Выберете способ оплаты"
        label.font = UIFont(name: "KelsonSans-RegularRU", size: 14)
        viewFor1Section.addSubview(label)
        
        
        switch section {
        case 0:
            return viewForAnySection
        case 1:
            return viewFor1Section
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCellPhoneNumber") as! SenderCellPhoneNumber
            return cell
            
        default:
            
            print("error")
            return UITableViewCell()
            
        }
        
    }
    
    
}
