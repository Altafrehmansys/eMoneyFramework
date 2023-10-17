//
//  TimerOtp.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 09/05/2023.
//

import Foundation

protocol TimerProtocol {
    func currentCount(counter : Int)
    func counterEnd()
}

final class TimerOtp: NSObject {
    static let shared = TimerOtp()
    
    private override init() { }
    
    var delegate : TimerProtocol?
    var timeCounter = 0
    var timer : Timer?

    func stopTimer(){
        timeCounter = 0
        timer?.invalidate()
    }
    func startTimer(time: Int = 120){
        timeCounter = time
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (time) in
            if self.timeCounter >= 0 {
                self.timeCounter = self.timeCounter - 1
                self.delegate?.currentCount(counter: self.timeCounter)
            } else {
                self.timer?.invalidate()
                self.delegate?.counterEnd()
            }
        }
    }
    
    func timerResume(){
        //timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (time) in
            if self.timeCounter >= 0 {
                self.timeCounter = self.timeCounter - 1
                self.delegate?.currentCount(counter: self.timeCounter)
            } else {
                self.timer?.invalidate()
                self.delegate?.counterEnd()
            }
        //}
    }

    
    
}
