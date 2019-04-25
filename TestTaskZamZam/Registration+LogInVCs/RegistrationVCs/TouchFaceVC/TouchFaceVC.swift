//
//  TouchFaceVC.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 25/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class TouchFaceVC: UIViewController {

    
    @IBOutlet weak var viewBigWhite: UIView!
    @IBOutlet weak var imTouchFace: UIImageView!
    @IBOutlet weak var butNext: UIButton!
    @IBOutlet weak var labTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        configureView()
        viewBigWhite.layer.cornerRadius = 16
        configureButNext()
    }
    
    
    func configureView() {
        if UIScreen.main.bounds.height > 736 {
            labTitle.text = "Использовать Face ID"
            self.imTouchFace.image = UIImage(named: "faceId")
        } else {
            labTitle.text = "Использовать отпечаток"
            self.imTouchFace.image = UIImage(named: "touchId")
        }
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
    
    func enterToApp() {
        
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTBController")
        self.present(home, animated: true, completion: nil)
        
    }
    
    
    @IBAction func butYesTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "useTouchId")
        enterToApp()
    }
    
    @IBAction func butNoTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "useTouchId")
        enterToApp()
    }
    

}
