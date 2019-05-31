//
//  UserPriofileInfo.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 31/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation


class UserProfileInfo {
    
    
    var lastName: String
    var firstName: String
    var middleName: String
    var birthDate: String
    var countryCode: String
    var city: String
    var address: String
    var passportNumber: String
    var passportIssueDate: String
    var passportAuthority: String
    
    
    init(lastName: String,
         firstName: String,
         middleName: String,
         birthDate: String,
         countryCode: String,
         city: String,
         address: String,
         passportNumber: String,
         passportIssueDate: String,
         passportAuthority: String) {
        
        self.lastName = lastName
        self.firstName = firstName
        self.middleName = middleName
        self.birthDate = birthDate
        self.countryCode = countryCode
        self.city = city
        self.address = address
        self.passportNumber = passportNumber
        self.passportIssueDate = passportIssueDate
        self.passportAuthority = passportAuthority
        
    }


}
