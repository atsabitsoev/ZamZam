//
//  RegistrationNotificationNames.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 07/05/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

enum NotificationNames: String {
    
    case appAccessTokenIsGot = "appAccessTokenIsGot"
    case codeSent = "codeSent"
    case verificationSucceed = "verificationSucceed"
    case verificationFailed = "verificationFailed"
    case userExists = "userExists"
    case sendingCodeError = "sendingCodeError"
    
    case passwordChanged = "passwordChanged"
    case passwordNotChanged = "passwordNotChanged"
    
    case enterSucceed = "enterSucceed"
    case wrongCredentials = "enterFailed"
    case enterFailed = "requestFailed"
    
    case userAccessTokenIsOutOfDate = "tokenIsOutOfDate"
    
    case registrationSucceed = "registrationSucceed"
    case registrationFailed = "registrationFailed"
    
    case zamBillsUpdated = "zamBillsUpdated"
    
    case zamZamTransferSucceed = "zamZamTransferSucceed"
    case zamZamTransferFailed = "zamZamTransferFailed"
    
    case historyGot = "historyGot"
    case historyGetFailed = "historyGetFailed"
    
    case loadPageBegining = "loadingBegan"
}
