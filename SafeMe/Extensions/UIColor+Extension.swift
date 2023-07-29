//
//  UIColor+Extension.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

extension UIColor {
//    class var customBlue: UIColor {return UIColor(named: "customBlue") ?? #colorLiteral(red: 0.168627451, green: 0.3254901961, blue: 0.8392156863, alpha: 1)}
//    class var customDarkBlue: UIColor { return UIColor(named: "customDarkBlue") ?? #colorLiteral(red: 0.02352941176, green: 0.2823529412, blue: 0.4274509804, alpha: 1)}
//    class var customDark: UIColor {return UIColor(named: "customDark") ?? #colorLiteral(red: 0.1347255707, green: 0.1347555816, blue: 0.1347216368, alpha: 1)}
//    class var customShadowColor: UIColor {return UIColor(named: "customShadowColor") ?? #colorLiteral(red: 0.7725490196, green: 0.7764705882, blue: 0.7843137255, alpha: 1)}
//    class var customLightGray: UIColor {return UIColor(named: "customLightGray") ?? #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)}
//    class var customGreen: UIColor {return UIColor(named: "customGreen") ?? #colorLiteral(red: 0.1450980392, green: 0.8588235294, blue: 0.1333333333, alpha: 1)}
//
//    class var customGray: UIColor {return UIColor(named: "customGray") ?? .systemGray}
//    class var customGray2: UIColor {return UIColor(named: "customGray2") ?? #colorLiteral(red: 0.7097328305, green: 0.7098537683, blue: 0.7097168565, alpha: 1)}
//    class var customGray3: UIColor {return UIColor(named: "customGray3") ?? #colorLiteral(red: 0.8823529412, green: 0.9098039216, blue: 0.9098039216, alpha: 1)}
//    class var customGray5: UIColor {return UIColor(named: "customGray5") ?? #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)}
    
    

}

extension UIColor {
    class var custom: CustomColor { return CustomColor() }
    
    struct CustomColor {
        //синий
        var blue:  UIColor { return UIColor(named: "blue") ?? UIColor(red: 0.168627451, green: 0.3254901961, blue: 0.8392156863, alpha: 1)}
        
        //белый
        var white: UIColor { return UIColor(named: "white") ?? UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1) }
        
        //
        var black: UIColor { return UIColor(named: "black") ?? UIColor(red: 0, green: 0, blue: 0, alpha: 1) }
        
        
        
        
        //зеленый
        var green: UIColor { return UIColor(named: "green") ?? UIColor(red: 97/255, green: 165/255, blue: 53/255, alpha: 1) }
        
        //крассный
        var red: UIColor { return UIColor(named: "red") ?? UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1) }
       
        //темно серый
        var darkGray: UIColor { return UIColor(named: "darkGray") ?? UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)}
        
        //серый
        var gray:  UIColor { return UIColor(named: "gray") ?? UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)}
        
        //серый
        var gray6:  UIColor {  return UIColor(named: "gray6") ?? UIColor(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)}
        
        //серый
        var gray3:  UIColor { return UIColor(named: "gray3") ?? UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)}
        
        //Серый число календаря
        var grayDate: UIColor {return UIColor.hexStringToUIColor(hex: "#7B7D81")}

        //цвет фона контроллера
//        var backgroundColor:  UIColor { return UIColor(named: "backgroundColor") ?? UIColor(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)}
        
        //
        var grayView:  UIColor { return UIColor(named: "grayView") ?? UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)}
        
        var labelColor: UIColor {return UIColor(named: "labelColor") ?? UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1) }
        
        var cellColor: UIColor {return UIColor(named: "cellColor") ?? UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1) }
        
        //легкий серый цвет (используется в основном с TextField backgroundColor или как borderColor
        var lightGray: UIColor { return UIColor(named: "lightGray") ??  UIColor(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1) }
        
        //#colorLiteral(red: 0.9960784314, green: 0.7568627451, blue: 0.01568627451, alpha: 1)
        
        //#colorLiteral(red: 0.7333333333, green: 0.231372549, blue: 0.231372549, alpha: 1)
        
        var mainBackgroundColor: UIColor { return UIColor(red: 0.08, green: 0.7, blue: 0.89, alpha: 1)}
        var cellBackgroundColor: UIColor {return UIColor(red: 0.1, green: 0.79, blue: 1, alpha: 1)}
        var buttonBackgroundColor: UIColor {return UIColor(red: 0.42, green: 0.74, blue: 0.96, alpha: 1)}
        var buttonGreenBgColor: UIColor {return UIColor(red: 0.39, green: 0.84, blue: 0.53, alpha: 1)}
        var dateBackgroundColor: UIColor { return UIColor.hexStringToUIColor(hex: "#E1F8F7")}
    }
}


extension UIColor {
    static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
