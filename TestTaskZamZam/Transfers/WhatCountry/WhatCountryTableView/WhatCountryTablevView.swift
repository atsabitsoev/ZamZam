//
//  WhatCountryTablevView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 14.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import FlagKit

extension WhatCountryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "whatCountryCell") as! WhatCountryCell
        
        cell.labNameOfCountry.text = countries[indexPath.row]
        cell.imageOfCountry.image = Flag(countryCode: countryCodes[indexPath.row])?.image(style: .circle)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 12
            
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let personalDataVC = self.personalDataVC {
            
            personalDataVC.country = countries[indexPath.row]
            personalDataVC.countryCode = countryCodes[indexPath.row]
            personalDataVC.updateButCountry()
            self.navigationController?.popViewController(animated: true)
            
        } else if interTransRecieverVC != nil {
            
            interTransRecieverVC!.countryName = countries[indexPath.row]
            interTransRecieverVC!.countryCode = countryCodes[indexPath.row]
            interTransRecieverVC!.setCountry()
            self.navigationController?.popViewController(animated: true)
            
        }  else if nextVCIsInterTransReciverVC {
            
            let intTransRecVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "interTransRecieverVC") as! InterTransRecieverVC
            intTransRecVC.countryName = countries[indexPath.row]
            intTransRecVC.countryCode = countryCodes[indexPath.row]
            self.navigationController?.show(intTransRecVC, sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
        
    }
    
}
