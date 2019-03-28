//
//  WhatCountryVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 14.03.2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class WhatCountryVC: UIViewController {

    @IBOutlet weak var textFieldSearch: WhatCountryTextField!
    @IBOutlet weak var bigWhiteView: UIView!
    @IBOutlet weak var butBack: UIButton!
    @IBOutlet weak var butClose: UIButton!
    @IBOutlet weak var textField: WhatCountryTextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var countries = [String]()
    var countryCodes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = ["Таджикистан",
                     "Узбекистан",
                     "Кыргыстан",
                     "Азербайджан",
                     "Молдова",
                     "Казахстан",
                     "Турция",
                     "Грузия",
                     "Россия",
                     "Беларусь",
                     "Украина"]
        countryCodes = ["TJ",
                        "UZ",
                        "KG",
                        "AZ",
                        "MD",
                        "KZ",
                        "TR",
                        "GE",
                        "RU",
                        "BY",
                        "UA"]
        
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setColoredPlaceHolder()
    }
    
    override func viewWillLayoutSubviews() {
        bigWhiteView.layer.cornerRadius = 16
        configureNavigationButtons()
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
    
    func setColoredPlaceHolder() {
        var myPlaceholder = NSMutableAttributedString()
        let text = "Поиск, например, Россия"
        myPlaceholder = NSMutableAttributedString(string: text,
                                                  attributes: [.font : UIFont(name: "Noto Sans",
                                                                              size: 16)!])
        myPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor,
                                   value: UIColor(red: 86/255,
                                                  green: 192/255,
                                                  blue: 253/255,
                                                  alpha: 0.6),
                                   range: NSRange(location: 0,
                                                  length: myPlaceholder.length))
        myPlaceholder.addAttribute(NSAttributedString.Key.kern,
                                   value: -0.5,
                                   range: NSRange(location: 0,
                                                  length: myPlaceholder.length))
        
        textFieldSearch.attributedPlaceholder = myPlaceholder
        textFieldSearch.leftViewMode = .always
        
        let imageView = UIImageView(image: UIImage(named: "icSearchBlue"))
        let v = UIView(frame: CGRect(x: 0,
                                     y: 0,
                                     width: 30,
                                     height: 32))
        v.addSubview(imageView)
        imageView.frame = CGRect(x: 9,
                                 y: 7,
                                 width: 18,
                                 height: 18)
        textFieldSearch.leftView = v
        textFieldSearch.leftView?.alpha = 0.6
    }
    
    
    @IBAction func butBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func butCloseTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSumAndCurrency" {
            let nextVC = segue.destination as! SumAndCurrencyVC
            let indexPath = tableView.indexPathForSelectedRow
            nextVC.currentRegion = countryCodes[(indexPath!.row)]
            nextVC.countryName = countries[indexPath!.row]
        }
    }
    
}
