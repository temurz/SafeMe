//
//  TimerView.swift
//  SafeMe
//
//  Created by Temur on 19/08/2023.
//

var timerBorderWidth : Int = 2;
var timerWidth : Float = 30;
var timeRadius : Float = 40;
var timerVal : Int = 10;
var timer : Timer!;
 
import UIKit
 
class TimerView : UIView {
     
    struct Stored{
        // Inorder to access globally in this class
        static var timerLabel : UILabel!
    }
     
    class func loadingCountDownTimerInView (_superView : UIView) -> TimerView{
         
        let timerView : TimerView = TimerView(frame: _superView.frame)
        timerView.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        _superView.addSubview(timerView)
         
        // Make a Circle View
        let retFrame = CGRect(x:_superView.center.x - CGFloat(timerWidth), y:_superView.center.y - CGFloat(timerWidth), width:CGFloat(timerWidth * 3), height:CGFloat(timerWidth * 3));
        let circleView : UIView = UIView(frame: retFrame);
        circleView.layer.cornerRadius = CGFloat(timeRadius);
        circleView.layer.borderColor = UIColor.blue.cgColor;
        circleView.layer.borderWidth = CGFloat(timerBorderWidth);
         
        // Make a Label
        Stored.timerLabel  = UILabel(frame: circleView.bounds)
        Stored.timerLabel.text = "\(timerVal)"
        Stored.timerLabel.textColor = UIColor.black
        Stored.timerLabel.textAlignment = NSTextAlignment.center
         
        circleView.addSubview(Stored.timerLabel)
        timerView.addSubview(circleView)
         
        return timerView
         
    }
     
    func startTimer(){
         
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer(dt:)), userInfo: nil, repeats: true)
         
    }
     
    @objc func updateTimer(dt:Timer){
        timerVal = timerVal - 1
        if timerVal == 0{
            Stored.timerLabel.text = "Done"
        }else if timerVal < 0{
            timer.invalidate()
            //super.removeFromSuperview()
        }else {
            Stored.timerLabel.text = "\(timerVal)"
        }
    }
}
