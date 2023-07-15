//
//  UIFont+Extension.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

extension  UIFont {
    
    enum Montserrat:String {
        case thin = "Montserrat-Thin"
        case thinItalic = "Montserrat-ExtraLight"
        case light = "Montserrat-Light"
        case regular = "Montserrat-Regular"
        case medium = "Montserrat-Medium"
        case semibold = "Montserrat-SemiBold"
        case bold = "Montserrat-Bold"
    }
    
    class func montserratFont(ofSize fontSize: CGFloat, weight: Montserrat = .regular) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        
    }
    
    enum Nunito:String {
        case thin = "Nunito-Thin"
        case thinItalic = "Nunito-ExtraLight"
        case light = "Nunito-Light"
        case regular = "Nunito-Regular"
        case medium = "Nunito-Medium"
        case semibold = "Nunito-SemiBold"
        case bold = "Nunito-Bold"
    }
    
    class func nunitoFont(ofSize fontSize: CGFloat, weight: Nunito  = .regular) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        
    }
}

