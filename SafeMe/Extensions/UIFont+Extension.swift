//
//  UIFont+Extension.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

extension  UIFont {
    
    enum Roboto: String {
        case thin = "Roboto-Thin"
        case regular = "Roboto-Regular"
        case medium = "Roboto-Medium"
        case light = "Roboto-Light"
        case italic = "Roboto-Italic"
        case bold = "Roboto-Bold"
        case black = "Roboto-Black"
    }
    
    class func robotoFont(ofSize fontSize: CGFloat, weight: Roboto = .regular) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
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
}

