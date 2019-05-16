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
    @IBOutlet weak var viewCashBack: UIView! {
        didSet{
            viewCashBack.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackViewBalance: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    
    var masOfBills: [ZamBill]?
    var stackViewBalanceStandardBounds: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBills()
        
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        configurePullToRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        setImageToTabBar()
        viewCheta.layer.cornerRadius = 16
        
    }
    
    private func fetchBills() {
        
        masOfBills = [ZamBill(currencyType: .rubble, sum: 190),
                      ZamBill(currencyType: .dollar, sum: 39393),
                      ZamBill(currencyType: .euro, sum: 40238)]
        
    }
    
    private func configurePullToRefresh() {
        let swipeRec = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecognized(gestureRecognizer:)))
        swipeRec.direction = .down
        self.view.addGestureRecognizer(swipeRec)
        print("Добавил")
    }
    
    @objc func swipeGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        startRefreshing()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.stopRefreshing()
        }
    }
    
    private func startRefreshing() {
        self.view.isUserInteractionEnabled = false
        stackViewBalanceStandardBounds = stackViewBalance.bounds
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.stackViewBalance.bounds = CGRect(x: self.stackViewBalance.bounds.minX,
                                             y: self.stackViewBalance.bounds.minY - 13,
                                             width: self.stackViewBalance.bounds.width,
                                             height: self.stackViewBalance.bounds.height)
        }
    }
    
    private func stopRefreshing() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.stackViewBalance.bounds = self.stackViewBalanceStandardBounds!
        }
        self.view.isUserInteractionEnabled = true
    }
    
        func setImageToTabBar() {
//        let image = UIImage(named: "logo")
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleToFill
//
//        let window = UIApplication.shared.keyWindow
//        var bottomPadding: CGFloat?
//        if #available(iOS 11.0, *) {
//            bottomPadding = window?.safeAreaInsets.bottom
//        } else {
//            bottomPadding = bottomLayoutGuide.length
//        }
//        let insets = UIEdgeInsets(top: 8,
//                                  left: self.tabBarController!.tabBar.bounds.width/2 - 16,
//                                  bottom: bottomPadding! + 9,
//                                  right: self.tabBarController!.tabBar.bounds.width/2 - 16)
//        imageView.frame = self.tabBarController!.tabBar.bounds.inset(by: insets)
//        self.tabBarController!.tabBar.addSubview(imageView)
        }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
