//
//  SenderVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 18.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SenderVC: UIViewController {
    
    
    @IBOutlet weak var viewWhiteBig: UIView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    let masFieldTitles = [[" Номер телефона отправителя "],
                        [" Имя "," Фамилия "," Отчество "," Дата рождения ДД/ММ/ГГГГ "],
                        [" Страна "," Город регистрации "," Адрес регистрации "],
                        [" Серия и номер паспорта "," Кем выдан "," Дата выдачи ДД/ММ/ГГГГ "]]
    let masSectionNames = ["Номер телефона отправителя",
                           "ФИО и дата рождения отправителя",
                           "Адрес регистрации отправителя",
                           "Удостоверение личности отправителя"]
    var dictUserData = [1000: "",
                        1001: "",
                        1002: "",
                        1003: "",
                        2001: "",
                        2002: "",
                        3000: "",
                        3001: "",
                        3002: ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWhiteBig.layer.cornerRadius = 16
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        configureButNext()
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
    
    func configureButNext() {
        
        butNext.layer.cornerRadius = 8
        butNext.addGradient(colors: [UIColor(red: 86/255,
                                             green: 192/255,
                                             blue: 253/255,
                                             alpha: 1).cgColor,
                                     UIColor(red: 40/255,
                                             green: 161/255,
                                             blue: 231/255,
                                             alpha: 1).cgColor],
                            coordinatesX: [0,0],
                            coordinatesY: [0,1],
                            cornerRadius: butNext.layer.cornerRadius)
        
        butNext.layer.shadowColor = #colorLiteral(red: 0.2509803922, green: 0.6980392157, blue: 0.9529411765, alpha: 1)
        butNext.layer.shadowOpacity = 0.64
        butNext.layer.shadowRadius = 10
        let bounds = butNext.bounds
        let insetedBounds = bounds.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: -10, right: 10))
        
        butNext.layer.shadowPath = CGPath(rect: insetedBounds, transform: nil)
        
    }
    
    private func goToNextVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let paymentVC = storyboard.instantiateViewController(withIdentifier: "PaymentVC")
        self.navigationController?.show(paymentVC, sender: nil)
    }
    
    
    @objc func nextTapped() {
        
        self.view.endEditing(true)
        goToNextVC()
    }
    
    
    @IBAction func butNextTapped(_ sender: Any) {
        nextTapped()
    }
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func butCloseTapped(_ sender: Any) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)

    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
