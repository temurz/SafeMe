//
//  ChangePasswordPresenter.swift
//  SafeMe
//
//  Created by Даулетбай Комекбаев on 21/08/23.
//

import Foundation

typealias ChangePasswordPresenterDelegate = ChangePasswordPresenterProtocol & ChangePasswordViewController

protocol ChangePasswordPresenterProtocol {
    func smsIsSent()
    func smsIsVerified()
}

class ChangePasswordPresenter {
    weak var delegate: ChangePasswordPresenterDelegate?
    
    var sessionId: String = ""
    
    func requestSMS(phoneNumber:String) {
        Network.shared.requestSMSforChangePassword(phoneNumber: phoneNumber) { statusCode, sessionId in
            
            guard let sessionId else {
                self.pushAlert(statusCode)
                return
            }
            
            self.successRequest(sessionId)
        }
    }
    
    func checkCode(code: String) {
        Network.shared.checkCodeForPasswordChange(code: code, sessionId: self.sessionId) { statusCode, sessionId in
            
            guard let sessionId else {
                self.pushAlert(statusCode)
                return
            }
            
            self.smsIsVerified()
        }
    }
}

extension ChangePasswordPresenter {
    func pushAlert(_ statusCode: StatusCode) {
        self.delegate?.alert(error: statusCode, action: nil)
    }
    
    func successRequest(_ sessionId: String) {
        self.sessionId = sessionId
        DispatchQueue.main.async {
            self.delegate?.smsIsSent()
        }
    }
    
    func smsIsVerified() {
        DispatchQueue.main.async {
            self.delegate?.smsIsVerified()
        }
    }
}
