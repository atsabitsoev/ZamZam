//
//  RecipientTableview.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 11/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension RecipientVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastOperations.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath == [0,0] {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "RecipientHeaderCell")!
            cell = headerCell
        } else {
            let operationCell = tableView.dequeueReusableCell(withIdentifier: "RecipientHistoryCell") as! RecipientHistoryCell
            operationCell.labPhone.text = lastOperations[indexPath.row - 1]
            cell = operationCell
        }
        

        
        return cell
    }
    
    
}
