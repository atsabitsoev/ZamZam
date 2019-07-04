//
//  LimitsVC.swift
//  TestTaskZamZam
//
//  Created by Iliya B on 04/07/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class LimitsVC: UIViewController {


    @IBOutlet var butBack: UIButton!
    @IBOutlet var butClose: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillLayoutSubviews() {
        configureNavigationButtons()
    }


    func configureNavigationButtons() {

        butBack.layer.cornerRadius = butBack.bounds.height/2
        butBack.layer.shadowOffset = CGSize(width: 0, height: 6)
        butBack.layer.shadowRadius = 16
        butBack.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        butBack.layer.shadowOpacity = 0.18
        let rightImage = UIImage(named: "chevronRight")?.cgImage
        let leftImage = UIImage(cgImage: rightImage!, scale: 0, orientation: UIImage.Orientation.down)
        butBack.setImage(leftImage, for: .normal)
        butBack.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)

        butClose.layer.cornerRadius = butClose.bounds.height/2
        butClose.layer.shadowOffset = CGSize(width: 0, height: 6)
        butClose.layer.shadowRadius = 16
        butClose.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        butClose.layer.shadowOpacity = 0.18
        butClose.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    }


    @IBAction func butBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func butCloseTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
