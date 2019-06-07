//
//  CurrencySelectView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 07/06/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


protocol CurrencySelectViewDelegate {
    
    func currencySelected(currency: CurrencyProtocol) -> Void
}


class CurrencySelectView: UIView {
    
    
    var currencies: [CurrencyProtocol] = [CurrencyEuro(), CurrencyDollar(), CurrencyRubble()]
    
    var selectedTag = 0 {
        didSet {
            selectedCurrency = currencies[selectedTag]
        }
    }
    
    var selectedCurrency: CurrencyProtocol!
    
    private var buttons: [UIButton] = []
    
    var delegate: CurrencySelectViewDelegate!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureLabels()
        setTitleColors()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        
        layer.backgroundColor = UIColor.clear.cgColor
        backgroundColor = .clear
        
        setFrames()
        setTags()
    }
    
    
    private func configureLabels() {
        
        buttons = currencies.map({ (currency) -> UIButton in
            let but = UIButton()
            but.setTitle(currency.symbol, for: .normal)
            but.titleLabel!.font = UIFont(name: "PTSans-Regular", size: 36)
            but.addTarget(self, action: #selector(butTapped(_:)), for: .touchUpInside)
            addSubview(but)
            return but
        })
    }
    
    private func setFrames() {
        
        var i = 0
        for lab in buttons {
            i += 1
            
            lab.frame = CGRect(x: CGFloat(-i) * CGFloat(28) + frame.width,
                               y: 0,
                               width: 28,
                               height: frame.height)
        }
    }
    
    private func setTags() {
        
        var i = 0
        for but in buttons {
            but.tag = i
            i += 1
        }
    }
    
    
    @objc private func butTapped(_ sender: UIButton) {
        
        selectedTag = sender.tag
        setTitleColors()
        delegate.currencySelected(currency: selectedCurrency)
    }
    
    private func setTitleColors() {
        
        for but in buttons {
            but.setTitleColor(#colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 0.5037457192), for: .normal)
        }
        
        buttons[selectedTag].setTitleColor(#colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 1), for: .normal)
    }
    
}
