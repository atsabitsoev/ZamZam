//
//  HistoryTransactionCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class HistoryTransactionCell: UITableViewCell {
    
    
    @IBOutlet weak var labPhoneOrName: UILabel!
    @IBOutlet weak var labSumBig: UILabel!
    @IBOutlet weak var labSumSmall: UILabel!
    @IBOutlet weak var zam2ZamLogosView: Zam2ZamLogosView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
