//
//  PaymentNewVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class PaymentNewVC: UIViewController {

    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var masZamBills: [ZamBill] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBills()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewBigWhite.layer.cornerRadius = 16
    }

    
    private func fetchBills() {
        
        
        masZamBills = [ZamBill(currency: CurrencyManager.getCurrency(byType: .rubble), sum: 21324),
                       ZamBill(currency: CurrencyManager.getCurrency(byType: .dollar), sum: 192.01),
                       ZamBill(currency: CurrencyManager.getCurrency(byType: .euro), sum: 0)]
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
