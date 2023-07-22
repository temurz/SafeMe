//
//  Date+Extension.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

extension Date {
    func toString(_ format:String! = "yyyy-MM-dd HH:mm:ss", _ convertTimeZone:Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if convertTimeZone {formatter.timeZone = Calendar.current.timeZone}
        return formatter.string(from: self)
    }
}
