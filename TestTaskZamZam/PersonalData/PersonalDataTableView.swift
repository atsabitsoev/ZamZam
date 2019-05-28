//
//  PersonalDataTableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


extension PersonalDataVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDataFlagCell") as! PersonalDataFlagCell
            return cell
            
        case 5:
            
            return UITableViewCell()
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDataTFCell") as! PersonalDataTFCell
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
}
