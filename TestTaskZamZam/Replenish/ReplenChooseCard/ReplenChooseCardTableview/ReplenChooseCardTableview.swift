//
//  ReplenChooseCardTableview.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 09/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension ReplenChooseCardVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cards.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
            
        case 0:
            
            let describtionCell = tableView.dequeueReusableCell(withIdentifier: "ReplenDescribtionCell")!
            cell = describtionCell
            
        case 1...cards.count:
            
            let cardCell = tableView.dequeueReusableCell(withIdentifier: "ReplenCardCell") as! ReplenCardCell
            cardCell.labCardNumber.text = cards[indexPath.section - 1]
            cell = cardCell
            
        case cards.count + 1:
            
            if !cardAdding {
                let addCardCell = tableView.dequeueReusableCell(withIdentifier: "ReplenAddCardCell")!
                cell = addCardCell
            } else {
                let newCardCell = tableView.dequeueReusableCell(withIdentifier: "ReplenNewCardCell") as! ReplenNewCardCell
                
                for tf in newCardCell.textFields {
                    tf.maskDelegate = self
                }
                newCardCell.tfCardNumber.tag = 0
                newCardCell.tfDate.tag = 1
                newCardCell.tfCVV.tag = 2
                newCardCell.tfHolderOfCard.tag = 3
                
                cell = newCardCell
            }
            
        default:
            print("Error!!!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1...cards.count:
            return 76
        case cards.count + 1:
            if !cardAdding {
                return 76
            } else {
                return 221
            }
        default:
            print("Error")
            return 68
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [cards.count + 1,0] && !cardAdding {
            cardAdding = true
            self.tableView.reloadSections([indexPath.section], with: .automatic)
            
        }
    }
    
    
}
