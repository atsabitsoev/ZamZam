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
        return zamBills?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBill") as! BillCell
        let bill = zamBills![indexPath.row]
        
        cell.labName.text = "ZAM счет \(bill.currency.shortName)"
        cell.labCurrency.text = bill.currency.symbol
        cell.labSum.text = "\(bill.sum) \(bill.currency.symbol)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
