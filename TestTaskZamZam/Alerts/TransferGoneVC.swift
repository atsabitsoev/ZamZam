//
//  TransferGoneVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TransferGoneVC: UIViewController {
    
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var imOk: UIImageView!
    @IBOutlet weak var viewSumWhite: UIView!
    @IBOutlet weak var labSum: myLabel!
    @IBOutlet weak var labSumSmall: myLabel!
    @IBOutlet weak var imChevronDown: UIImageView!
    @IBOutlet weak var viewPhoneWhite: UIView!
    @IBOutlet weak var labPhone: myLabel!
    @IBOutlet weak var imCountry: UIImageView!
    @IBOutlet weak var labCashBack: myLabel!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var labInfoCashBackMain: myLabel!
    @IBOutlet weak var labInfoCashBackSecond: myLabel!
    
    
    var sum: String?
    var convertedSum: String?
    var phone: String?
    var cashBack = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextToLabels()
    }
    
    override func viewWillLayoutSubviews() {
        viewGreen.layer.cornerRadius = viewGreen.bounds.width/2
        viewSumWhite.layer.cornerRadius = 8
        viewPhoneWhite.layer.cornerRadius = 8
        butClose.layer.cornerRadius = butClose.bounds.width/2
        imCountry.layer.cornerRadius = imCountry.bounds.width/2
        
        setTint(to: imOk)
        setTint(to: imChevronDown)
        
        setShadowToViewGreen()
    }
    
    
    private func setTextToLabels() {
        
        labSum.text = sum ?? "Ошибка"
        labPhone.text = phone ?? "Ошибка"
        labSumSmall.text = convertedSum ?? "Ошибка"
        
        if cashBack == "0" {
            labCashBack.alpha = 0
            labInfoCashBackMain.alpha = 0
            labInfoCashBackSecond.alpha = 0
        } else {
            labCashBack.text = cashBack
        }
        
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
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "HomeTBController")
        self.present(mainVC, animated: true, completion: nil)
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
