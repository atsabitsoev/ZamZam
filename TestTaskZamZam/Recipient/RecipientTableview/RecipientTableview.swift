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
        return lastOperations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipientHistoryCell") as! RecipientHistoryCell
        
        cell.labPhone.text = lastOperations[indexPath.row]
        
        return cell
    }
    
    
}
