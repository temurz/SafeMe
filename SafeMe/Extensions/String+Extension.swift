//
//  String+Extension.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

extension String {
    func convertionDate(from:String = "yyyy-MM-dd'T'HH:mm:ss", to format:String = "dd.MM.yyyy, HH:mm", timeZone:Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = from
        if timeZone {formatter.timeZone = Calendar.current.timeZone}
        guard let date = formatter.date(from: self) else {return ""}
        //        let identifier = Calendar.current.locale?.identifier ?? "ru-RU"
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.dateFormat = format
        let text = formatter.string(from: date)
        return text
    }
    
    
    func convertToDateUS() -> String {
        

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set the locale to avoid any potential issues with different locales.
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX" // Input format

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd.MM.yyyy" // Output format
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate // Output: 2023-05-08
        }else {
            return ""
        }
    }
}
