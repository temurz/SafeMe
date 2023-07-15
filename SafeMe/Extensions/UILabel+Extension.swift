//
//  UILabel+Extension.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

extension UILabel {
    
    convenience init(text:String, ofSize fontSize: CGFloat, weight: UIFont.Montserrat, color:UIColor? = .custom.black) {
        self.init()
        self.text = text
        self.backgroundColor = .clear
        self.font = .montserratFont(ofSize: fontSize, weight: weight)
        self.textColor = color
    }
    
    convenience init(text:String?, size fontSize: CGFloat, weight: UIFont.Weight, color:UIColor? = .custom.black) {
        self.init()
        self.text = text
        self.backgroundColor = .clear
        self.font = .systemFont(ofSize: fontSize, weight: weight)
        self.textColor = color
    }
    
    convenience init(text:String?, font: UIFont, color:UIColor? = .custom.black) {
        self.init()
        self.text = text
        self.backgroundColor = .clear
        self.font = font
        self.textColor = color
    }
}


