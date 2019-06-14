//
//  CardIssueCollectionView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 20.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension CardIssueVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardIssueCell", for: indexPath) as! CardIssueCollectionCell
        
        let cardImageName = cardImageNames[indexPath.row]
        cell.imCard.image = UIImage(named: cardImageName)
        
        cell.viewShadow.layer.cornerRadius = cell.imCard.layer.cornerRadius
        cell.viewShadow.layer.shadowRadius = 10
        cell.viewShadow.layer.shadowOffset = CGSize(width: 0, height: 20)
        cell.viewShadow.layer.shadowColor = cell.imCard.backgroundColor?.cgColor
        cell.viewShadow.layer.shadowOpacity = 0.8
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView.frame.minX
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            var currentCellOffset = self.collectionView.contentOffset
            currentCellOffset.x += self.collectionView.frame.width / 2
            if let indexPath = self.collectionView.indexPathForItem(at: currentCellOffset) {
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
        
        let newItem = Int(collectionView.contentOffset.x/UIScreen.main.bounds.width)
        if newItem != self.currentItem {
            self.itemChanged(to: newItem)
        }
    }
    
}
