//
//  RegOrLogScreen.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 04/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class RegOrLogScreen: UIViewController {
    
    
    @IBOutlet weak var butReg: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        butReg.layer.cornerRadius = 8
    }

}
