//
//  Int+Extension.swift
//  SafeMe
//
//  Created by Temur on 21/08/2023.
//

import Foundation

extension Int {
    
    func makeMinutesAndSeconds() -> String {
        if self % 60 < 10 {
            let text = "\(self / 60):0\(self % 60)"
            return text
        }else {
            let text = "\(self / 60):\(self % 60)"
            return text
        }
    }
}
