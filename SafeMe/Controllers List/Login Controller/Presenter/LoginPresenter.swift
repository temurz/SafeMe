//
//  LoginPresenter.swift
//  SafeMe
//
//  Created by Temur on 22/07/2023.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func successAutorization()
}

typealias LoginPresenterDelegate = LoginPresenterProtocol & LoginViewController


class LoginPresenter {
    weak var delegate: LoginPresenterDelegate?
    
    func loginAction(username:String, pass:String) {
        if username.isEmpty || pass.isEmpty {delegate?.alert(title: nil, message: "Enter login/password".localizedString, url: nil); return}
        delegate?.indicatorView.startAnimating(.auth)
        
         guard let data = delegate?.login() else {return}
        
        Network.shared.authorization(username: data.username, password: data.password) { [weak self] status  in
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
            self?.update()
        }
    }
}


//MARK: - View
extension LoginPresenter {
    //MARK: Input
    
    
    //MARK: Output
    private func update() {
        DispatchQueue.main.async {
            self.delegate?.successAutorization()
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }

    }
}
