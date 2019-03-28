//
//  ViewController.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewCheta: UIView!
    @IBOutlet weak var viewCashBack: UIView!{
        didSet{
            viewCashBack.layer.cornerRadius = 8
        }
    }
    
    
    var masOfBills: [Bill]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masOfBills = [Bill(name: "Zam счет RUB",
                           sum: 21324.00,
                           last4numbers: 1111,
                           valuta: "RUB"),
                      Bill(name: "Zam счет USD",
                           sum: 192.01,
                           last4numbers: 3513,
                           valuta: "USD")]
        
        let longpress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        self.tableView.addGestureRecognizer(longpress)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        viewCheta.layer.cornerRadius = 16
    }
    
    override func viewWillLayoutSubviews() {
        viewCashBack.addGradient(colors: [#colorLiteral(red: 0.9176470588, green: 0.01960784314, blue: 0.231372549, alpha: 1).cgColor,
                                          #colorLiteral(red: 0.6823529412, green: 0.03529411765, blue: 0.9019607843, alpha: 1).cgColor],
                                 coordinatesX: [0,1],
                                 coordinatesY: [0,0])
        setImageToTabBar()
    }
    
    
    func setImageToTabBar() {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        let insets = UIEdgeInsets(top: 8,
                                  left: self.tabBarController!.tabBar.bounds.width/2 - 16,
                                  bottom: bottomPadding! + 9,
                                  right: self.tabBarController!.tabBar.bounds.width/2 - 16)
        imageView.frame = self.tabBarController!.tabBar.bounds.inset(by: insets)
        self.tabBarController!.tabBar.addSubview(imageView)
    }
    
    func getSymbolFromValuta(valuta: String) -> String? {
        switch valuta {
        case "RUB":
            
            return "₽"
            
        case "EUR":
            
            return "€"
            
        case "USD":
            
            return "$"
            
        default:
            return nil
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
