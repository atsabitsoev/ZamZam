//
//  ViewController.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate {
    
    
    let getUserAccountsService = GetUserAccountsService.standard
    
    
    @IBOutlet weak var labTotalSum: myLabel!
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
    
    
    var zamBills: [ZamBill]?
    var stackViewBalanceStandardBounds: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        configurePullToRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        startRefreshing()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        viewCheta.layer.cornerRadius = 16
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopRefreshing), name: NSNotification.Name(rawValue: NotificationNames.zamBillsUpdated.rawValue), object: nil)
        
    }
    
    private func fetchBills() {
        
        getUserAccountsService.sendGetZamBillsRequest()
        
    }
    
    private func billsUpdated() {
        
        labTotalSum.text = "\(getUserAccountsService.sumOfAllAccounts)"
        
        self.zamBills = getUserAccountsService.zamBills
        tableView.reloadData()
        
    }
    
    private func configurePullToRefresh() {
        let swipeRec = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecognized(gestureRecognizer:)))
        swipeRec.direction = .down
        self.view.addGestureRecognizer(swipeRec)
        print("Добавил")
    }
    
    @objc func swipeGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        startRefreshing()
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
        
        fetchBills()
    }
    
    @objc private func stopRefreshing() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.stackViewBalance.bounds = self.stackViewBalanceStandardBounds!
        }
        self.view.isUserInteractionEnabled = true
        
        billsUpdated()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
