//
//  HistoryVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit

class HistoryVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let phoneNumberKit = PhoneNumberKit()
    
    
    var masTransactions: [[Transaction]]?
    var numberOfLoadedPages: Int = 0
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 1)
        
        return refreshControl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(refreshControl)
        addObservers()
        fetchNextPageHistory()
        
        roundView(viewBigWhite, rad: 16)
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(setNewHistoryArr), name: NSNotification.Name(NotificationNames.historyGot.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userAccessTokenIsOutOfDate), name: NSNotification.Name(NotificationNames.userAccessTokenIsOutOfDate.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadingFailed), name: NSNotification.Name(NotificationNames.historyGetFailed.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchNextPageHistory), name: NSNotification.Name(NotificationNames.loadPageBegining.rawValue), object: nil)
    }
    
    @objc private func fetchNextPageHistory() {
        GetTransactionHistoryService.standard.fetchHistory(page: numberOfLoadedPages)
    }
    
    
    private func roundView(_ view: UIView, rad: CGFloat) {
        
        view.layer.cornerRadius = rad
        view.clipsToBounds = true
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
    
    
    @objc func setNewHistoryArr() {
        
        masTransactions = GetTransactionHistoryService.standard.masSortedTransactions
        tableView.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        numberOfLoadedPages += 1
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        numberOfLoadedPages = 0
        fetchNextPageHistory()
    }
    
    @objc private func userAccessTokenIsOutOfDate() {
        
        showSessionLimitAlert()
    }
    
    @objc func loadingFailed() {
        
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

}
