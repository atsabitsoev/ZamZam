//
//  ProfileTableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 28/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell

        var titleString = ""
        var imageName = ""

        switch indexPath.row {
        case 0:
            titleString = "Персональные данные"
            imageName = "clipboard"
        case 1:
            titleString = "Лимиты"
            imageName = "barChart2"
            cell.contentView.alpha = 0.5
        case 2:
            titleString = "Точки пополнения/снятия"
            imageName = "mapPin"
            cell.contentView.alpha = 0.5
        case 3:
            titleString = "Связь с поддержкой"
            imageName = "mail"
            cell.contentView.alpha = 0.5
        case 4:
            titleString = "О приложении"
            imageName = "info"
            cell.contentView.alpha = 0.5
        default:
            print("whatttt")
        }

        cell.labTitle.text = titleString
        cell.imageMain.image = UIImage(named: imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            UserProfileService.standard.getUserInfoRequest()
            self.startLoading()
            
        default:
            print("what")
        }
    }
    
    
}
