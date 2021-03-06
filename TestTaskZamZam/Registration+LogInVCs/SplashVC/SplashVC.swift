//
//  SplashVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 17/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butEnter: UIButton!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var masSplash: [Splash]?
    var currentItem = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMasSplash()
        pageControll.numberOfPages = masSplash!.count
    }
    
    override func viewWillLayoutSubviews() {
        configureButNext()
    }
    
    
    func setMasSplash() {
        
        masSplash = [Splash(title: "",
                            describtion: "Кэшбэк 1% от суммы международного перевода на счет Zamzam",
                            imageName: "1CashBack"),
                     Splash(title: "",
                            describtion: "Оплата патента без комиссии",
                            imageName: "fns"),
                     Splash(title: "",
                            describtion: "Бесплатные валютные переводы в 180 стран мира",
                            imageName: "0")]
    }
    
    func itemChanged(to item: Int) {
        
        currentItem = item
        pageControll.currentPage = item
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
    
    
    @IBAction func butRegTapped(_ sender: UIButton) {
        
        setNewPasswordModeON = false
        
    }
}
