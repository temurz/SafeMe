//
//  LoginPresenter.swift
//  SafeMe
//
//  Created by Temur on 22/07/2023.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func successAutorization()
    func successRegistration()
    func successCodeVerification()
}

typealias LoginPresenterDelegate = LoginPresenterProtocol & LoginViewController


class LoginPresenter {
    weak var delegate: LoginPresenterDelegate?
    var sessionId: String = ""
    
    func loginAction(username:String, pass:String) {
        
        if username.isEmpty || pass.isEmpty {delegate?.alert(title: nil, message: "Enter login/password".localizedString, url: nil); return}
        delegate?.indicatorView.startAnimating(.auth)
        
        Network.shared.authorization(username: username, password: pass) { [weak self] status  in
//            guard let _ = person else {
//                AuthApp.shared.token = nil
//                self?.pushAlert(status)
//                return
//            }
            self?.delegate?.indicatorView.stopAnimating()
            if status.code != 0 {
                self?.pushAlert(status)
                return
            }
            self?.updateLogin()
        }
    }
    
    func register(username: String, pass: String, repeatPassword: String) {
        if username.isEmpty || pass.isEmpty || repeatPassword.isEmpty {delegate?.alert(title: nil, message: "Enter login/password".localizedString, url: nil); return}
        delegate?.indicatorView.startAnimating(.auth)
        
        Network.shared.register(username: username, password: pass, repeatPassword: repeatPassword) { statusCode, sessionId in
            self.delegate?.indicatorView.stopAnimating()
            
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            
            guard let sessionId else {
                return
            }
            self.sessionId = sessionId
            
            self.updateRegistration()
            
        }
        
    }
    
    func checkVerificationCode(code: String) {
        if code.isEmpty {
            delegate?.alert(title: nil, message: "Wrong code".localizedString, url: nil)
            return
        }
        delegate?.indicatorView.startAnimating()
        
        Network.shared.checkPhoneVerificationCode(code: code, session_id: self.sessionId) { statusCode in
            
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            
            self.updateCodeVerification()
        }
    }
}


//MARK: - View
extension LoginPresenter {
    //MARK: Input
    
    
    //MARK: Output
    private func updateLogin() {
        DispatchQueue.main.async {
            self.delegate?.successAutorization()
        }
    }
    
    private func updateRegistration() {
        DispatchQueue.main.async {
            self.delegate?.successRegistration()
        }
    }
    
    private func updateCodeVerification() {
        DispatchQueue.main.async {
            self.delegate?.successCodeVerification()
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }

    }
}
