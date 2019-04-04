//
//  TwilioService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 04/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class TwilioService {
    
    static let standard = TwilioService()
    private init() {}
    
    
    var shortCodeSent = false
    var shortCodeVerified = false
    
    
    func sendShortCode() {
        
    }
    
    func checkShortCode() {
        if shortCodeSent {
            
        }
    }
    
}
