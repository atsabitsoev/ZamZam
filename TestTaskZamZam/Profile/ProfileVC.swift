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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        
        UserProfileService.standard.getUserInfoRequest()
    }
    
    override func viewWillLayoutSubviews() {
        viewUnderImProfile.layer.cornerRadius = viewUnderImProfile.bounds.height / 2
        viewBigWhite.layer.cornerRadius = 16
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(setUserInfo), name: NSNotification.Name(rawValue: NotificationNames.userProfileGot.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSessionLimitAlert), name: NSNotification.Name(rawValue: NotificationNames.userAccessTokenIsOutOfDate.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorAlert), name: NSNotification.Name(rawValue: NotificationNames.userProfileGettingFailed.rawValue), object: nil)
    }
    
    @objc private func setUserInfo() {
        
        let userProfileInfo = UserProfileService.standard.userProfileInfo
        let phoneFormatter = PartialFormatter()
        
        var nameTitle = "\(userProfileInfo!.firstName) \(userProfileInfo!.lastName)"
        
        let userPhone = UserDefaults.standard.string(forKey: "userPhone")!
        let parsedPhone = phoneFormatter.formatPartial(userPhone)
        
        guard nameTitle != " " else {
            
            labName.text = "Пользователь"
            labPhone.text = parsedPhone
            labInitials.text = "П"
            return
        }
        
        let firstNameInitial = userProfileInfo?.firstName.first?.uppercased()
        let lastNameInitial = userProfileInfo?.lastName.first?.uppercased()
        let initialsString = "\(firstNameInitial!)\(lastNameInitial!)"
        
        labName.text = nameTitle
        labPhone.text = parsedPhone
        labInitials.text = initialsString
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
        
        
    }
    
    
    private func goToPinVC() {
        
        let storyBoard = UIStoryboard(name: "Registration+LogIn",
                                      bundle: nil)
        let pinVC = storyBoard.instantiateViewController(withIdentifier: "PINVC")
        
        self.present(pinVC,
                     animated: true,
                     completion: nil)
    }

}
