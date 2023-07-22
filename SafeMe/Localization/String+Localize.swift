//
//  String+Localize.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

extension String {
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localizedString, arguments: arguments)
    }
    
    var localizedString: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    static var localized: LocalizeString { return LocalizeString() }
    
    struct LocalizeString {
        var close: String {return "Close".localizedString}
        var cancel: String {return "Cancel".localizedString}
        var update: String {return "Update".localizedString}
        var error: String {return "Error".localizedString}
        var nodatafromserver: String {return "No data from server".localizedString}
        var pleasetryagainlater: String {return "Please try again later.".localizedString}
        var anerrorhasoccurred: String {return "An error has occurred".localizedString}
        var password: String {return "Password".localizedString}
    }
}
