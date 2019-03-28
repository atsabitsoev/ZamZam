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
    @IBOutlet weak var labDescribtion: myLabel!
    @IBOutlet weak var labBlue: myLabel!
    @IBOutlet weak var viewImage: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        
        let myString = NSMutableAttributedString(string: "+1%",
                                                 attributes: [NSAttributedString.Key.kern : -0.71])
        myString.addAttribute(NSAttributedString.Key.font,
                              value: UIFont(name: "Kelson Sans RU",
                                            size: 20)!,
                              range: NSRange(location: 0,
                                             length: myString.length))
        labBlue.attributedText = myString
        self.layer.cornerRadius = 8
    }
    
}
