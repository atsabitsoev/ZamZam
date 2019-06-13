import UIKit
import AKMaskField

extension InterTransPaymentVC: AKMaskFieldDelegate {
    
    func maskFieldDidBeginEditing(_ maskField: AKMaskField) {
        let cell = tableView.cellForRow(at: [2,0]) as! CardDataCell
        var view = UIView()
        var lab = UILabel()
        switch maskField.tag {
        case 0:
            view = cell.viewCardNumber
            lab = cell.labTitleCardNumber
        case 1:
            view = cell.viewDate
            lab = cell.labDate
        case 2:
            view = cell.viewCVV
            lab = cell.labCVV
        default:
            print("error")
        }
        
        view.animateBorderColor(toColor: #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1), duration: 0.3)
        lab.alpha = 1
        lab.textColor = #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1)
        lab.layer.borderColor = #colorLiteral(red: 0.2470588235, green: 0.6941176471, blue: 0.9490196078, alpha: 1)
    }
    
    func maskFieldDidEndEditing(_ maskField: AKMaskField) {
        
        if let cell = tableView.cellForRow(at: [2,0]) as? CardDataCell {
            
            var view = UIView()
            var lab = UILabel()
            
            switch maskField.tag {
            case 0:
                view = cell.viewCardNumber
                lab = cell.labTitleCardNumber
            case 1:
                view = cell.viewDate
                lab = cell.labDate
            case 2:
                view = cell.viewCVV
                lab = cell.labCVV
            default:
                print("error")
            }
            
            if maskField.text != nil && maskField.text != "" {
                
                view.animateBorderColor(toColor: UIColor(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1), duration: 0.3)
                lab.alpha = 1
                lab.textColor =  UIColor(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
                lab.layer.borderColor =  UIColor(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1).cgColor
                
            } else {
                
                view.animateBorderColor(toColor:  UIColor(red: 0.8745098039, green: 0.8784313725, blue: 0.9254901961, alpha: 1), duration: 0.3)
                lab.alpha = 0
                print(lab.text!)
                lab.textColor =  UIColor(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1)
                lab.layer.borderColor =  UIColor(red: 0.1176470588, green: 0.1607843137, blue: 0.4078431373, alpha: 1).cgColor
                
            }
        }
        
    }
    
    func maskFieldShouldReturn(_ maskField: AKMaskField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
