//
//  Bundle+Extension.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle {
        let appLang = AuthApp.shared.language
        if bundle == nil,
           let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
        {
            bundle = Bundle(path: path)
        }

        return bundle
    }

    public static func setLanguage(lang: String) {
        AuthApp.shared.language = lang
        let path = Bundle.main.path(forResource: lang, ofType: "lproj") ?? "ru"
        bundle = Bundle(path: path)
    }
}
