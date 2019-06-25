//
//  CardIssueVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 20.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class CardIssueVC: UIViewController {
    
    @IBOutlet weak var constrCardText: NSLayoutConstraint!
    @IBOutlet weak var labTitle: myLabel!
    @IBOutlet weak var textViewDescribtion: UITextView!
    @IBOutlet weak var labNotRequired: myLabel!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var currentItem = Int()
    var cardImageNames = ["ZamBroCard", "ZamVirtualCard"]
    
    var describtionAttrStrings = [NSAttributedString]()
    var arrayOfTitles = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        setAttributedStrings()
        setArrayOfTitles()
    }
    
    override func viewWillLayoutSubviews() {
        configureButNext()
        viewBigWhite.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textViewDescribtion.setContentOffset(.zero, animated: true)
    }
    
    
    func itemChanged(to item: Int) {
        
        self.currentItem = item
        pageControl.currentPage = item
        if item == 0{
            labNotRequired.alpha = 1
        } else {
            labNotRequired.alpha = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.textViewDescribtion.alpha = 0
            self.labTitle.alpha = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.textViewDescribtion.alpha = 1
            self.labTitle.alpha = 1
            self.labTitle.text = self.arrayOfTitles[item]
            self.textViewDescribtion.attributedText = self.describtionAttrStrings[item]
        }
    }
    
    func setAttributedStrings() {

        let string0 = """
Медицинская страховка (ДМС)
Оплата миграционного патента без комиссий
Именная дебетовая карта Zamzam
Международные переводы за 0%
Кэшбэк 1% на валютные переводы
Переводы внутри Zamzam бесплатно
Виртуальная карта
"""
        let string1 = """
Международные переводы за 0%
Кэшбэк 1% на валютные переводы
Переводы внутри Zamzam бесплатно
Виртуальная карта
"""
        
        let attributedString0 = NSMutableAttributedString(string: string0,
                                                          attributes: [
            .font: UIFont(name: "PTSans-Regular", size: 14.0)!,
            .foregroundColor: UIColor(red: 160.0 / 255.0, green: 161.0 / 255.0, blue: 173.0 / 255.0, alpha: 1.0),
            .kern: 0.0
            ])
        
        let attributedString1 = NSMutableAttributedString(string: string1,
                                                          attributes: [
                                                            .font: UIFont(name: "PTSans-Regular",
                                                                          size: 14)!,
                                                            .foregroundColor: UIColor(red: 160.0 / 255.0,
                                                                                      green: 161.0 / 255.0,
                                                                                      blue: 173.0 / 255.0,
                                                                                      alpha: 1.0),
                                                            .kern: 0.0
                                                            ])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString0.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle,
                                       range: NSRange(location: 0,
                                                      length: attributedString1.length))
        attributedString1.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle,
                                       range: NSRange(location: 0,
                                                      length: attributedString1.length))
        
        describtionAttrStrings = [attributedString0,attributedString1]
    }
    
    func setArrayOfTitles() {
        arrayOfTitles = ["Тариф \"По-братски\"","Виртуальная карта"]
    }
    
    func setConstraints() {
        
        let kForConstraint: CGFloat = 50/812
        let newConstant = view.bounds.height * kForConstraint
        if newConstant <= 50 {
            constrCardText.constant = newConstant
        }
    }
    
    func configureButNext() {
        
        butNext.layer.cornerRadius = 8
        
        butNext.addGradient(colors: [UIColor(red: 128/255,
                                             green: 235/255,
                                             blue: 116/255,
                                             alpha: 1).cgColor,
                                     UIColor(red: 101/255,
                                             green: 202/255,
                                             blue: 89/255,
                                             alpha: 1).cgColor],
                            coordinatesX: [0,0],
                            coordinatesY: [0,1],
                            cornerRadius: butNext.layer.cornerRadius)
        
        butNext.layer.shadowColor = #colorLiteral(red: 0.3960784314, green: 0.7921568627, blue: 0.3529411765, alpha: 1)
        butNext.layer.shadowOpacity = 0.64
        butNext.layer.shadowRadius = 10
        let bounds = butNext.bounds
        let insetedBounds = bounds.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: -10, right: 10))
        
        butNext.layer.shadowPath = CGPath(rect: insetedBounds, transform: nil)
    }
    
}
