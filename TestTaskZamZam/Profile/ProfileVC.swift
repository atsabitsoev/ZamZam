//
//  ProfileVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit
import PhoneNumberKit

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var viewUnderImProfile: UIView!
    @IBOutlet weak var labInitials: UILabel!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labPhone: UILabel!
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        
        setUserInfo()
    }
    
    override func viewWillLayoutSubviews() {
        viewUnderImProfile.layer.cornerRadius = viewUnderImProfile.bounds.height / 2
        viewBigWhite.layer.cornerRadius = 16
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileGot), name: NSNotification.Name(rawValue: NotificationNames.userProfileGot.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSessionLimitAlert), name: NSNotification.Name(rawValue: NotificationNames.userAccessTokenIsOutOfDate.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorAlert), name: NSNotification.Name(rawValue: NotificationNames.userProfileGettingFailed.rawValue), object: nil)
    }
    
    @objc private func setUserInfo() {
        
        let phoneFormatter = PartialFormatter()
        
        let firstName = UserDefaults.standard.string(forKey: "userFirstName") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "userLastName") ?? ""
        let nameTitle = "\(firstName) \(lastName)"
        
        let userPhone = UserDefaults.standard.string(forKey: "userPhone")!
        let parsedPhone = phoneFormatter.formatPartial(userPhone)
        
        guard nameTitle != " " else {
            
            labName.text = "Пользователь"
            labPhone.text = parsedPhone
            labInitials.text = "П"
            return
        }
        
        let firstNameInitial = firstName.first?.uppercased()
        let lastNameInitial = lastName.first?.uppercased()
        let initialsString = "\(firstNameInitial!)\(lastNameInitial!)"
        
        labName.text = nameTitle
        labPhone.text = parsedPhone
        labInitials.text = initialsString
    }
    
    @objc private func userProfileGot() {
        
        stopLoading()
        
        let personalDataVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PersonalDataVC")
        self.navigationController?.show(personalDataVC, sender: nil)
        
    }
    
    @objc private func showSessionLimitAlert() {
        
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
    
    @objc private func showErrorAlert() {
        
        stopLoading()
        
        let alert = UIAlertController(title: "Ошибка", message: "Произошла неизвестная ошибка, попробуйте еще раз", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func goToPinVC() {
        
        let storyBoard = UIStoryboard(name: "Registration+LogIn",
                                      bundle: nil)
        let pinVC = storyBoard.instantiateViewController(withIdentifier: "PINVC")
        
        self.present(pinVC,
                     animated: true,
                     completion: nil)
    }
    
    
    func startLoading() {
        
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        
        activityIndicator.stopAnimating()
    }

    
    
    @IBAction func butChangeUserTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: "userEntered")
        let regLogNavCon = UIStoryboard(name: "Registration+LogIn", bundle: nil).instantiateViewController(withIdentifier: "RegLogNavCon")
        self.show(regLogNavCon, sender: nil)
    }
}
