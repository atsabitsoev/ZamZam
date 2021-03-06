//
//  ReplenSumAndCurrencyVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 09/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ReplenSumAndCurrencyVC: UIViewController {
    
    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var labTitleSum: myLabel!
    @IBOutlet weak var viewSum: UIView!
    @IBOutlet weak var tfSum: UITextField!
    @IBOutlet weak var labCurrency: myLabel!
    @IBOutlet weak var viewCurrency: UIView!
    @IBOutlet weak var labTitleCurrency: myLabel!
    @IBOutlet weak var labExchangeRate: myLabel!
    @IBOutlet weak var labComission: myLabel!
    @IBOutlet weak var labTotalSum: myLabel!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    
    
    var currentCurrencyCourse: CGFloat? = 67.51


    override func viewDidLoad() {
        super.viewDidLoad()
        viewBigWhite.layer.cornerRadius = 16
        addGestureRec()
    }
    
    override func viewWillLayoutSubviews() {
        
        configureButNext()
        configureNavigationButtons()
        setGrayBorder(to: viewSum)
        setGrayBorder(to: viewCurrency)
    }
    
    
    func setGrayBorder(to view: UIView) {
        view.layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
    }
    
    func configureButNext() {
        
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
    
    func addGestureRec() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    
    
    @objc func hideKeyboard() {
        self.becomeFirstResponder()
        self.view.endEditing(true)
    }
    
    
    @IBAction func tfSumTextChanged(_ sender: UITextField) {
        
        if let sum = Int(tfSum.text ?? "") {
            var sumInRubbles = CGFloat(sum) * currentCurrencyCourse!
            print(CGFloat(sum))
            print(currentCurrencyCourse!)
            print(sumInRubbles)
            sumInRubbles *= 100
            sumInRubbles.round(.toNearestOrEven)
            sumInRubbles /= 100
            
            var sumInRubblesString = "\(sumInRubbles)"
            if sumInRubblesString.hasSuffix(".0") {
                sumInRubblesString.removeLast(2)
            }
            sumInRubblesString = "\(sumInRubblesString) RUB"
            labTotalSum.text = sumInRubblesString
        } else {
            labTotalSum.text = "0 RUB"
        }
        
    }
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
