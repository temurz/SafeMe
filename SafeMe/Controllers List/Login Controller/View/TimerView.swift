//
//  TimerView.swift
//  SafeMe
//
//  Created by Temur on 19/08/2023.
//

var timerBorderWidth : Int = 2;
var timerWidth : Float = 30;
var timeRadius : Float = 40;
var timerVal : Int = 5;
var timer : Timer!;
 
import UIKit
 
class TimerView : UIView {
     
    struct Stored {
        // Inorder to access globally in this class
        static var timerLabel : UILabel!
    }
     
    var requestSmsAction: (() -> ())?
    
    class func loadingCountDownTimerInView (_superView : UIView) -> TimerView{
         
        let timerView : TimerView = TimerView()
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        _superView.addSubview(timerView)
         
        // Make a Label
        Stored.timerLabel  = UILabel()
        
        Stored.timerLabel.text = timerVal.makeMinutesAndSeconds()
        Stored.timerLabel.textColor = .custom.gray
        Stored.timerLabel.textAlignment = NSTextAlignment.right
        Stored.timerLabel.translatesAutoresizingMaskIntoConstraints = false
         
        timerView.addSubview(Stored.timerLabel)
         
        return timerView
         
    }
     
    func startTimer() {
        Stored.timerLabel.gestureRecognizers?.removeAll()
        TimerView.Stored.timerLabel.text = timerVal.makeMinutesAndSeconds()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer(dt:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
     
    @objc func updateTimer(dt:Timer) {
        timerVal = timerVal - 1
        if timerVal == 0 {
            Stored.timerLabel.text = "Send SMS again".localizedString
            let tap = UITapGestureRecognizer(target: self, action: #selector(requestSmsAgain))
            Stored.timerLabel.isUserInteractionEnabled = true
            Stored.timerLabel.addGestureRecognizer(tap)
        }else if timerVal < 0 {
            timer.invalidate()
        }else {
            Stored.timerLabel.text = timerVal.makeMinutesAndSeconds()
        }
    }
    
    @objc private func requestSmsAgain() {
        self.requestSmsAction?()
    }
}
