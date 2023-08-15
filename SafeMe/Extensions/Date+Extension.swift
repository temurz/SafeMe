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


extension Dictionary {
    func percentEncoded() -> Data? {
            map { key, value in
                let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
                let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
                return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
            .data(using: .utf8)
        }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
