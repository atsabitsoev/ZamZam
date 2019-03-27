//
//  CardIssueCollectionCell.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 20.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class CardIssueCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imCard: UIImageView! {
        didSet {
            imCard.layer.cornerRadius = 14
            imCard.clipsToBounds = true
        }
    }
    @IBOutlet weak var viewShadow: UIView!
    
}
