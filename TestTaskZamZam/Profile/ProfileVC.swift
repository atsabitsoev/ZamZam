//
//  ProfileVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var viewUnderImProfile: UIView!
    @IBOutlet weak var labInitials: UILabel!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labPhone: UILabel!
    @IBOutlet weak var viewBigWhite: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        viewUnderImProfile.layer.cornerRadius = viewUnderImProfile.bounds.height / 2
        viewBigWhite.layer.cornerRadius = 16
    }

}
