//
//  EnterCodePresenter.swift
//  SafeMe
//
//  Created by Temur on 24/07/2023.
//

import Foundation


class AppEnterCodePresenter {
    
    
}

extension AppEnterCodePresenter {
    //MARK: Input
    func saveEnterCode(enterCode: String) {
        AuthApp.shared.appEnterCode = enterCode
    }
    
    func compareEnterCode(enterCode: String) -> Bool {
        return AuthApp.shared.appEnterCode == enterCode
    }
    
}
