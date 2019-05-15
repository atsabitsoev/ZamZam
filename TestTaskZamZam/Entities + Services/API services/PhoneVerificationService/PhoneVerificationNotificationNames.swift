//
//  RegistrationNotificationNames.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 07/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

enum PhoneVerificationNotificationNames: String {
    
    case appAccessTokenIsGot = "appAccessTokenIsGot"
    case codeSent = "codeSent"
    case verificationSucceed = "verificationSucceed"
    case verificationFailed = "verificationFailed"
    case userExists = "userExists"
    case sendingCodeError = "sendingCodeError"
}
