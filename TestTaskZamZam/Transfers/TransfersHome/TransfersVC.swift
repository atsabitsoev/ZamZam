//
//  TransfersVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 13.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TransfersVC: UIViewController {

    @IBOutlet weak var bigWhiteView: UIView!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        bigWhiteView.layer.cornerRadius = 16
        configureNavigationButtons()
    }
    
    
    func configureNavigationButtons() {
        butBack.layer.cornerRadius = butBack.bounds.height/2
        butBack.layer.shadowOffset = CGSize(width: 0,
                                            height: 6)
        butBack.layer.shadowRadius = 16
        butBack.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        butBack.layer.shadowOpacity = 0.18
        let rightImage = UIImage(named: "chevronRight")?.cgImage
        let leftImage = UIImage(cgImage: rightImage!,
                                scale: 0,
                                orientation: UIImage.Orientation.down)
        butBack.setImage(leftImage,
                         for: .normal)
        butBack.imageEdgeInsets = UIEdgeInsets(top: 9,
                                               left: 9,
                                               bottom: 9,
                                               right: 9)
        
        butClose.layer.cornerRadius = butClose.bounds.height/2
        butClose.layer.shadowOffset = CGSize(width: 0,
                                             height: 6)
        butClose.layer.shadowRadius = 16
        butClose.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        butClose.layer.shadowOpacity = 0.18
        butClose.imageEdgeInsets = UIEdgeInsets(top: 9,
                                                left: 9,
                                                bottom: 9,
                                                right: 9)
    }
    
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
