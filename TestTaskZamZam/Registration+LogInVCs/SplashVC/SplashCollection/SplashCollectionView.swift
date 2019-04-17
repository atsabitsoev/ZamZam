//
//  SplashCollectionView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 17/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

extension SplashVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return masSplash!.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SplashCell", for: indexPath) as! SplashCollectionCell
        
        cell.imageMain.image = UIImage(named: masSplash![indexPath.row].imageName)
        cell.labTitle.text = masSplash![indexPath.row].title
        cell.labDescribtion.text = masSplash![indexPath.row].describtion
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
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
