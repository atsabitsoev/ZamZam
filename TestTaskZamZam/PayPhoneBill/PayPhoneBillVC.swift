//
//  PayPhoneBillVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class PayPhoneBillVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var masZamBills: [ZamBill]?
    var masCardBills: [CardBill]?
    var cardAdding = false
    lazy var indexPathForCardDataCell = IndexPath(row: masCardBills!.count + masZamBills!.count, section: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBills()
    }
    
    
    func fetchBills() {
        
        masZamBills = [ZamBill(currency: .rubble,
                               sum: 12932.09),
                       ZamBill(currency: .dollar,
                               sum: 324.91)]
        
        masCardBills = [CardBill(name: "Visa",
                                 sum: 2342,
                                 first4Numbers: 3939,
                                 last4numbers: 32939,
                                 currency: .dollar),
                        CardBill(name: "MasterCard",
                                 sum: 32939,
                                 first4Numbers: 9393,
                                 last4numbers: 3292,
                                 currency: .euro)]
    }
    

}
