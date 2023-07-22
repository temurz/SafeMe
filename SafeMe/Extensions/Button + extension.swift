//
//  Button + extension.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import Foundation
import UIKit

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    convenience init(backgroundColor:UIColor, textColor:UIColor, text:String, radius:CGFloat! = 0) {
        self.init()
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.setTitleColor(.customDark, for: .focused)
        self.setTitleColor(.customDark, for: .highlighted)
//        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.clipsToBounds = true
        self.titleLabel?.font = .montserratFont(ofSize: 13, weight: .bold)
        self.layer.cornerRadius = radius
    }
    
    convenience init(color:UIColor, backgroundColor:UIColor,  image:UIImage?) {
        self.init()
        self.backgroundColor = backgroundColor
        self.setImage(image, for: .normal)
        self.tintColor = color
        self.setTitleColor(color, for: .normal)
//        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.clipsToBounds = true
    }
    
    convenience init(backgroundColor:UIColor,  image:UIImage?) {
        self.init()
        self.backgroundColor = backgroundColor
        self.setImage(image, for: .normal)
        self.clipsToBounds = true
    }
    
    
    func leftImage() {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        self.titleEdgeInsets.left = (self.imageView?.frame.width ?? 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
}
