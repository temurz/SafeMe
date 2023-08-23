//
//  EnterCodePresenter.swift
//  SafeMe
//
//  Created by Temur on 24/07/2023.
//

import Foundation

protocol AppEnterCodePresenterProtocol {
    func success(sessionId: String)
    func successSMSVerification()
}

typealias AppEnterCodePresenterDelegate = AppEnterCodePresenterProtocol & ApplicationCodeViewController

class AppEnterCodePresenter {
    weak var delegate: AppEnterCodePresenterDelegate?
    var sessionId = ""
    
    func requestSMSForPin() {
        Network.shared.requestSMSForPIN { statusCode, session_id in
            
            guard let session_id else {
                self.pushAlert(statusCode)
                return
            }
            
            self.success(session_id)
        }
    }
    
    func checkSMSCodeForPin(code: String) {
        Network.shared.checkSMSCodeForPin(code: code, sessionId: self.sessionId) { statusCode in
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            self.successSMSVerification()
        }
    }
    
}

extension AppEnterCodePresenter {
    //MARK: Input
    func saveEnterCode(enterCode: String) {
        AuthApp.shared.appEnterCode = enterCode
    }
    
    func compareEnterCode(enterCode: String) -> Bool {
        return AuthApp.shared.appEnterCode == enterCode
    }
    
    
    //Output
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
    
    private func success(_ sessionId: String) {
        self.sessionId = sessionId
        DispatchQueue.main.async {
            self.delegate?.success(sessionId: sessionId)
        }
    }
    
    private func successSMSVerification() {
        DispatchQueue.main.async {
            self.delegate?.successSMSVerification()
        }
    }
    
    
}
