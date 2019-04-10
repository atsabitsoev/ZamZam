//
//  TimerService.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 10/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

var timerService: TimerService?

class TimerService {
    
    var timeRest: Int
    
    private var timer: Timer?
    
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc private func tick() {
        
        if self.timeRest > 0 {
            
            self.timeRest -= 1
            self.postSecondPast()
            
        } else {
            
            self.postTimerStopped()
            self.timer!.invalidate()
            self.timer = nil
            
        }
        
    }
    
    
    private func postSecondPast() {
        NotificationCenter.default.post(name: NSNotification.Name("SecondPast"), object: nil)
    }
    
    private func postTimerStopped() {
        NotificationCenter.default.post(name: NSNotification.Name("TimerStopped"), object: nil)
    }
    
    
    init (time: Int) {
        timeRest = time
        startTimer()
    }
    
}
