//
//  TableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let billsCount = zamBills?.count ?? 0
        
        return billsCount + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == zamBills?.count ?? 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCollectionCell")!
            return cell
            
        } else if indexPath.row > zamBills?.count ?? 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "uslugiCell")!
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBill") as! BillCell
        let bill = zamBills![indexPath.row]
        
        cell.labName.text = "ZAM счет \(bill.currency.shortName)"
        cell.labCurrency.text = bill.currency.symbol
        cell.labSum.text = "\(bill.sum.formattedWithSeparator) \(bill.currency.symbol)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == zamBills?.count ?? 0 {
            
            return 135
            
        } else if indexPath.row > zamBills?.count ?? 0 {
          
            return 260
            
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
}
