//
//  HistoryVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchHistory()
        
        roundView(viewBigWhite, rad: 16)
    }
    
    
    private func fetchHistory() {
        GetTransactionHistoryService.standard.getHistory()
    }
    
    
    private func roundView(_ view: UIView, rad: CGFloat) {
        
        view.layer.cornerRadius = rad
        view.clipsToBounds = true
    }

}
