//
//  File.swift
//  SafeMe
//
//  Created by Temur on 22/08/2023.
//

import Foundation

protocol ChildViewPresenterProtocol {
    func success(_ statusCode: StatusCode)
}

typealias ChildViewPresenterDelegate = ChildViewPresenterProtocol & AddChildViewController

class ChildViewPresenter {
    weak var delegate: ChildViewPresenterDelegate?
    
    func addChild(name: String, gender: String, date_birthday: String, type_parent: String) {
        Network.shared.addChild(name: name, gender: gender, date_birthday: date_birthday, type_parent: type_parent) { statusCode in
            
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            self.success(statusCode)
        }
    }
}

extension ChildViewPresenter {
    func pushAlert(_ statusCode: StatusCode) {
        self.delegate?.alert(error: statusCode, action: nil)
    }
    
    func success(_ statusCode: StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.success(statusCode)
        }
        
    }
}
