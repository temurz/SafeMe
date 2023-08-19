//
//  StatusCode.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

struct StatusCode:Decodable {
    var code:Int?
    var error:Bool?
    var title:String?
    var message:String?
    
    init(_ error:Bool) {
        self.code = error ? 400 : 200
        self.message = !error ? nil : "Something went wrong".localizedString
    }
    
    init(_ error: Error?) {
        self.code = error?._code ?? 1000
        self.title = String.localized.anerrorhasoccurred
        self.message = error?.localizedDescription ??  String.localized.pleasetryagainlater + "\nerror: \(code!)"
    }
    
    init(code:Int, message:String? = nil) {
        self.code = code
        
        if message == nil {
            switch code {
            case 0:
                self.title = nil
                self.message = message
                self.error = false
            case 11:
                self.title = "Failed to log in".localizedString
                self.message = "Authorization error. Try again later".localizedString + "error: \(code)"
            case 100:
                self.title = String.localized.nodatafromserver
                self.message = "No data from the server. Try again a little later".localizedString + "\nerror: \(code)"
            case 101:
                self.title = "Access is closed".localizedString
                self.message = "Authorization is only available to Customers".localizedString + "\nerror: \(code)"
            case 200...299:
                self.message = message ?? "Something went wrong".localizedString + " \(code)"
                self.error = false
            case 401:
                self.title = "Authorization error".localizedString
                self.message = message ?? "Incorrect login or password".localizedString
            case 403:
                self.title = "Authorization error".localizedString
                self.message = message ?? "An error occurred during authorization".localizedString
            case 404:
                self.title = "Data upload error".localizedString
                self.message = message ?? String.localized.nodatafromserver
            case 405:
                self.title = "Ошибка регистрации".localizedString
                self.message = message ?? "не удалось завершить регистрацию. Повторите попытку позже".localizedString
            case 417:
                self.title = "You are not authorized".localizedString
                self.message = message ?? "Authorization required".localizedString
            case 500...999:
                self.title = String.localized.error
                self.message = "We are aware of this problem and are engaged in troubleshooting. Please try again later.".localizedString + "error: \(code)"
            case 1000...:
                self.title = String.localized.anerrorhasoccurred
                self.message = String.localized.pleasetryagainlater + "\nerror: \(code)"
            default:
                self.title = String.localized.anerrorhasoccurred
                self.message = message ?? String.localized.pleasetryagainlater + "\nerror: \(code)"
            }
        } else {
            self.message = message
        }
    }
}
