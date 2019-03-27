//
//  SomethingWrongVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SomethingWrongVC: UIViewController {

    
    @IBOutlet weak var viewUnderX: UIView!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var imX: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillLayoutSubviews() {
        viewUnderX.layer.cornerRadius = viewUnderX.bounds.width/2
        viewUnderX.layer.borderWidth = 6
        viewUnderX.layer.borderColor = #colorLiteral(red: 0.9610460069, green: 0.4142055081, blue: 0.5137254902, alpha: 1)
        
        butClose.layer.cornerRadius = butClose.bounds.width/2
        
        imX.image = imX.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        setShadowToViewUnderX()
    }
    
    
    func setShadowToViewUnderX() {
        
        let layer = viewUnderX.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0,
                                    height: 6)
        layer.shadowOpacity = 0.19
        layer.shadowRadius = 20
        
    }
    
    
    @IBAction func butClosedTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
