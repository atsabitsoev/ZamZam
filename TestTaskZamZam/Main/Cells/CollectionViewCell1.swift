//
//  CollectionViewCell1.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class CollectionViewCell1: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labTitle: myLabel!
    @IBOutlet weak var viewImage: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        
        self.layer.cornerRadius = 8
    }
    
}
