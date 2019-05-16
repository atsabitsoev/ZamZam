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
        
        masZamBills = [ZamBill(currencyType: .rubble, sum: 21324),
                       ZamBill(currencyType: .dollar, sum: 192.01),
                       ZamBill(currencyType: .euro, sum: 0)]
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
