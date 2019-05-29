//
//  HistoryTableView.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit


extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let masTransactions = self.masTransactions else { return 0 }
        
        return masTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTransactionCell") as! HistoryTransactionCell
        guard let transaction = masTransactions?[indexPath.row] else { return cell }
        
        let prefixOfSum = transaction.direction == .out ? "-" : "+"
        
        let sumBig: Int = Int(transaction.sum / Double(integerLiteral: 1))
        let sumBigString = Double(sumBig).formattedWithSeparator
        let sumSmall: Int = Int(transaction.sum * 100) - sumBig * 100
        
        cell.labSumBig.text = "\(prefixOfSum)\(sumBigString),"
        cell.labSumSmall.text = "\(sumSmall)" == "0" ? "00" : "\(sumSmall)"
        
        let colorOfLabSum = transaction.direction == .out ? #colorLiteral(red: 0.1055946723, green: 0.1623724401, blue: 0.4235801399, alpha: 1) : #colorLiteral(red: 0.3568627451, green: 0.6823529412, blue: 0, alpha: 1)
        cell.labSumBig.textColor = colorOfLabSum
        
        cell.zam2ZamLogosView.direction = transaction.direction
        
        var parsedRecipientPhone = ""
        let recipientPhoneNumber = try? self.phoneNumberKit.parse(transaction.recipientPhone)
        if let phoneNumber = recipientPhoneNumber {
            parsedRecipientPhone = phoneNumberKit.format(phoneNumber, toType: .international)
        }
        let recipientPhone = transaction.recipientPhone.first == "+" ? parsedRecipientPhone : transaction.recipientPhone
        cell.labRecipient.text = transaction.direction == .out ? recipientPhone : "На счет ZAM"
        
        var parsedSenderPhone = ""
        let senderPhoneNumber = try? self.phoneNumberKit.parse(transaction.senderPhone)
        if let phoneNumber = senderPhoneNumber {
            parsedSenderPhone = phoneNumberKit.format(phoneNumber, toType: .international)
        }
        
        cell.labSender.text = transaction.direction == .into ? "Перевод от \(parsedSenderPhone)" : "Перевод со счета ZAM"
        
        return cell
    }
    
    
}
