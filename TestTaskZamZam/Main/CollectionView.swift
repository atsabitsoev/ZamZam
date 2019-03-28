//
//  CollectionView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз on 06/03/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        switch indexPath.row {
        case 0:
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItem1", for: indexPath) as! CollectionViewCell1
            
            cell1.viewImage.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.7529411765, blue: 0.9921568627, alpha: 1)
            
            let layer = cell1.viewImage.layer
            layer.cornerRadius = 20
            layer.shadowRadius = 12
            layer.shadowColor = #colorLiteral(red: 0.337254902, green: 0.7529411765, blue: 0.9921568627, alpha: 1)
            layer.shadowOpacity = 0.4
            layer.shadowOffset = CGSize(width: 0, height: 4)
            
            cell1.image.image = UIImage(named: "arrowUpRight")
            
            cell = cell1
            
        case 1:
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItem2", for: indexPath) as! CollectionViewCell2
            
            cell1.viewImage.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            
            let layer = cell1.viewImage.layer
            layer.cornerRadius = 20
            layer.shadowRadius = 12
            layer.shadowColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            layer.shadowOpacity = 0.4
            layer.shadowOffset = CGSize(width: 0, height: 4)
            
            cell1.image.image = UIImage(named: "creditCard")
            
            cell = cell1
            
        case 2:
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItem2", for: indexPath) as! CollectionViewCell2
            
            cell1.viewImage.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.9215686275, blue: 0.4549019608, alpha: 1)
            
            let layer = cell1.viewImage.layer
            layer.cornerRadius = 20
            layer.shadowRadius = 12
            layer.shadowColor = #colorLiteral(red: 0.5019607843, green: 0.9215686275, blue: 0.4549019608, alpha: 1)
            layer.shadowOpacity = 0.4
            layer.shadowOffset = CGSize(width: 0, height: 4)
            
            cell1.labTitle.text = "Пополнить"
            
            cell1.image.image = UIImage(named: "arrowDownLeft")
            
            cell = cell1
            
        case 3:
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItem2", for: indexPath) as! CollectionViewCell2
            
            cell1.viewImage.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            
            let layer = cell1.viewImage.layer
            layer.cornerRadius = 20
            layer.shadowRadius = 12
            layer.shadowColor = #colorLiteral(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
            layer.shadowOpacity = 0.4
            layer.shadowOffset = CGSize(width: 0, height: 4)
            
            cell1.labTitle.text = "Оплата моб. связи"
            
            cell1.image.image = UIImage(named: "phoneIncoming")
            
            cell = cell1
            
        default:
            print("error")
        }
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let transfers = storyboard.instantiateViewController(withIdentifier: "TransfersNav")
            self.tabBarController?.show(transfers, sender: nil)
            
        case 1:
            
            let storyboard = UIStoryboard(name: "CardIssue", bundle: Bundle.main)
            let cardIssueNav = storyboard.instantiateViewController(withIdentifier: "CardIssueMain")
            self.navigationController?.show(cardIssueNav, sender: nil)
            
        default:
            print("Error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - 40)/2
        let height = (collectionView.bounds.height - 4)/2
        let size = CGSize(width: width, height: height)
        print("done")
        return size
    }
    
}
