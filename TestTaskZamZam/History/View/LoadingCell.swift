//
//  LoadingCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 30/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func layoutSubviews() {
        
        if !activityIndicator.isAnimating {
            
            activityIndicator.startAnimating()
            
            post(.loadPageBegining)
        }
    }
    
    
    private func post(_ notification: NotificationNames) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification.rawValue), object: nil)
    }

}
