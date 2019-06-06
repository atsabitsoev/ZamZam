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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackViewBalance: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    
    var zamBills: [ZamBill]?
    var stackViewBalanceStandardCenter: CGPoint?
    var shouldUpdate = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        configurePullToRefresh()
        
        shouldUpdate = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if shouldUpdate {
            startRefreshing()
        }
        shouldUpdate = false
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        viewCheta.layer.cornerRadius = 16
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopRefreshing),
                                               name: NSNotification.Name(rawValue: NotificationNames.zamBillsUpdated.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userAccessTokenIsOutOfDate),
                                               name: NSNotification.Name(NotificationNames.userAccessTokenIsOutOfDate.rawValue),
                                               object: nil)
        
    }
    
    @objc private func userAccessTokenIsOutOfDate() {
        
        showSessionLimitAlert()
    }
    
    private func showSessionLimitAlert() {
        
        let alert = UIAlertController(title: "Сессия закончена",
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок",
                                     style: .default) { (_) in self.goToPinVC() }
        alert.addAction(okAction)
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    private func goToPinVC() {
        
        let storyBoard = UIStoryboard(name: "Registration+LogIn",
                                      bundle: nil)
        let pinVC = storyBoard.instantiateViewController(withIdentifier: "PINVC")
        
        self.present(pinVC,
                     animated: true,
                     completion: nil)
    }
    
    private func fetchBills() {
        
        getUserAccountsService.sendGetZamBillsRequest()
        
    }
    
    private func billsUpdated() {
        
        labTotalSum.text = "\(getUserAccountsService.sumOfAllAccounts.formattedWithSeparator)"
        
        let oldCount = zamBills?.count ?? 0
        zamBills = GetUserAccountsService.standard.zamBills
        let newCount = zamBills?.count ?? 0
        
        if oldCount < newCount {
            insertNewBills(count: newCount - oldCount, startIndex: oldCount)
        } else if oldCount > newCount {
            deleteOldBills(count: oldCount - newCount, startIndex: newCount)
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.tableView.reloadData()
        }
        
    }
    
    private func insertNewBills(count: Int, startIndex: Int) {
        
        var indexPathsForNewBills: [IndexPath] = []
        
        for i in startIndex..<count + startIndex {
            indexPathsForNewBills.append([0,i])
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsForNewBills,
                             with: .automatic)
        tableView.endUpdates()
        
    }
    
    private func deleteOldBills(count: Int, startIndex: Int) {
        
        var indexPathsForOldBills: [IndexPath] = []
        
        for i in startIndex..<count + startIndex {
            indexPathsForOldBills.append([0,i])
        }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPathsForOldBills, with: .automatic)
        tableView.endUpdates()
        
    }
    
    private func configurePullToRefresh() {
        let swipeRec = UISwipeGestureRecognizer(target: self,
                                                action: #selector(swipeGestureRecognized(gestureRecognizer:)))
        swipeRec.direction = .down
        self.view.addGestureRecognizer(swipeRec)
        print("Добавил")
    }
    
    @objc func swipeGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        startRefreshing()
    }
    
    private func startRefreshing() {
        
        self.view.isUserInteractionEnabled = false
        stackViewBalanceStandardCenter = stackViewBalance.center
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.3) {
            self.stackViewBalance.center = CGPoint(x: self.stackViewBalanceStandardCenter!.x, y: self.stackViewBalanceStandardCenter!.y + 7)
        }
        
        fetchBills()
    }
    
    @objc private func stopRefreshing() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.stackViewBalance.center = self.stackViewBalanceStandardCenter!
        }
        self.view.isUserInteractionEnabled = true
        
        billsUpdated()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
