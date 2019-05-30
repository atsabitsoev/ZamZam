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
    
    
    private var observerAdded = false
    
    
    override func layoutSubviews() {
        
        if !observerAdded {
            NotificationCenter.default.addObserver(self, selector: #selector(loadPageEnding), name: NSNotification.Name(NotificationNames.loadPageEnding.rawValue), object: nil)
            observerAdded = true
        }
        
        if !activityIndicator.isAnimating {
            
            activityIndicator.startAnimating()
            
            post(.loadPageBegining)
        }
    }
    
    
    @objc private func loadPageEnding() {
        activityIndicator.stopAnimating()
    }
    
    private func post(_ notification: NotificationNames) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification.rawValue), object: nil)
    }

}
