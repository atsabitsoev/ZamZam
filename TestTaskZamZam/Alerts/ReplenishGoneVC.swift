//
//  ReplenichGoneVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 10/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ReplenishGoneVC: UIViewController {
    
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var imOk: UIImageView!
    @IBOutlet weak var labSumRub: myLabel!
    @IBOutlet weak var labSumDoll: myLabel!
    @IBOutlet weak var butClose: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillLayoutSubviews() {
        setTint(to: imOk)
        butClose.layer.cornerRadius = butClose.bounds.height / 2
        viewGreen.layer.cornerRadius = viewGreen.bounds.height / 2
    }
    
    func setShadowToViewGreen() {
        
        let layer = viewGreen.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0,
                                    height: 6)
        layer.shadowOpacity = 0.19
        layer.shadowRadius = 20
    }
    
    func setTint(to imageView: UIImageView) {
        imageView.image = imageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
