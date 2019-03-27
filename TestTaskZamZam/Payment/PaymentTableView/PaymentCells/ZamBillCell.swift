//
//  ZamBillCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 19.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ZamBillCell: UITableViewCell {

    @IBOutlet weak var labBillKind: myLabel!
    @IBOutlet weak var labBillSum: myLabel!
    @IBOutlet weak var viewUnderCheck: UIView!
    @IBOutlet weak var imCheck: UIImageView!
    
    override func layoutSubviews() {
        viewUnderCheck.layer.cornerRadius = viewUnderCheck.bounds.height/2
        viewUnderCheck.clipsToBounds = true
        imCheck.image = imCheck.image?.withRenderingMode(.alwaysTemplate)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("fsdgsf")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            addCheck()
        } else {
            deleteCheck()
        }
        
    }
    
    func addCheck() {
        viewUnderCheck.alpha = 1
    }
    
    func deleteCheck() {
        viewUnderCheck.alpha = 0
    }

}
