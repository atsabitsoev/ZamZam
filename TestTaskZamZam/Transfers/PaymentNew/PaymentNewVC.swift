//
//  PaymentNewVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 15/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class PaymentNewVC: UIViewController {

    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var masZamBills: [ZamBill] = []
    var transferList: [String: String] = ["phone": "",
                                           "sum": "0",
                                           "convertedSum": "0",
                                           "cashBack":"0",
                                           "senderCurrency": "",
                                           "recipientCurrency": "USD"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        fetchBills()

    }
    
    override func viewWillLayoutSubviews() {
        configureButNext()
        configureNavigationButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewBigWhite.layer.cornerRadius = 16
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(zamBillsUpdated), name: NSNotification.Name(rawValue: NotificationNames.zamBillsUpdated.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(transferSucceed), name: Notification.Name(NotificationNames.zamZamTransferSucceed.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(transferFailed), name: Notification.Name(NotificationNames.zamZamTransferFailed.rawValue), object: nil)
        
    }
    
    @objc private func zamBillsUpdated() {
        
        activityIndicator.stopAnimating()
        
        let oldCount = masZamBills.count
        masZamBills = GetUserAccountsService.standard.zamBills
        let newCount = masZamBills.count
        
        if oldCount < newCount {
            insertNewBills(count: newCount - oldCount, startIndex: oldCount)
        } else if oldCount > newCount {
            deleteOldBills(count: oldCount - newCount, startIndex: newCount)
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.tableView.reloadData()
        }
        
    }
    
    @objc private func transferSucceed() {
        
        activityIndicator.stopAnimating()
        
        let storyBoard = UIStoryboard(name: "AlertViewControllers", bundle: nil)
        let transferGoneVC = storyBoard.instantiateViewController(withIdentifier: "TransferGoneVC") as! TransferGoneVC
        
        transferGoneVC.phone = transferList["phone"]
        transferGoneVC.sum = transferList["sum"]
        transferGoneVC.cashBack = transferList["cashBack"]!
        transferGoneVC.convertedSum = transferList["convertedSum"]
        
        
        self.present(transferGoneVC, animated: true, completion: nil)
        
    }
    
    @objc private func transferFailed() {
        
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось выполнить перевод!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    private func insertNewBills(count: Int, startIndex: Int) {
        
        var indexPathsForNewBills: [IndexPath] = []
        
        for i in startIndex..<count + startIndex {
            indexPathsForNewBills.append([1,i])
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsForNewBills, with: .automatic)
        tableView.endUpdates()
        
    }
    
    private func deleteOldBills(count: Int, startIndex: Int) {
        
        var indexPathsForOldBills: [IndexPath] = []
        
        for i in startIndex..<count + startIndex {
            indexPathsForOldBills.append([1,i])
        }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPathsForOldBills, with: .automatic)
        tableView.endUpdates()
        
    }
    
    func billSelected(_ index: Int) {
        
        transferList["senderCurrency"] = masZamBills[index].currency.shortName
        
    }

    
    func configureButNext() {
        print("Рамка кнопки некст: \(butNext.bounds)")
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
    
    private func fetchBills() {
        
        activityIndicator.startAnimating()
        GetUserAccountsService.standard.sendGetZamBillsRequest()
        
    }
    
    
    
    @IBAction func butNextTapped(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        ZamZamTransferService().sendMoney(to: transferList["phone"]!,
                                          sum: (transferList["sum"]! as NSString).floatValue,
                                          senderCurrency: transferList["senderCurrency"]!,
                                          recipientCurrency: transferList["recipientCurrency"]!)
        
    }
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tfPhoneNumberTextChanged(_ sender: UITextField) {
        
        guard let phone = sender.text else { return }
        transferList["phone"] = phone
        
    }
    
    @IBAction func tfSumTextChanged(_ sender: UITextField) {
        
        guard let sumString = sender.text else { return }
        
        transferList["sum"] = sumString
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}
