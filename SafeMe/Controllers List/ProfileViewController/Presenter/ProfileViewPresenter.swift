//
//  ProfileViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 06/08/2023.
//

import Foundation

protocol ProfileViewPresenterProtocol {
    func reloadUser(_ user: User)
    func successfullyDeleteUser()
}

typealias ProfileViewPresenterDelegate = ProfileViewPresenterProtocol & ProfileViewController

class ProfileViewPresenter {
    weak var delegate: ProfileViewPresenterDelegate?
    
    
    func getUser() {
        delegate?.indicatorView.startAnimating()
        Network.shared.getUser { [weak self] statusCode, user in
            self?.delegate?.indicatorView.stopAnimating()
            
            guard let user else {
                self?.pushAlert(statusCode)
                return
            }
            
            self?.reloadUser(user)
        }
    }
    
    func deleteUser(userId: Int) {
        delegate?.indicatorView.startAnimating(.update)
        Network.shared.deleteUser(userId: userId) { [weak self] statusCode in
            guard let self else { return }
            self.delegate?.indicatorView.stopAnimating()
            
            if statusCode.code != 0 || statusCode.code != 204 {
                self.pushAlert(statusCode)
                return
            }
            
            self.finishDeletion()
        }
    }
}

extension ProfileViewPresenter {
    
    //MARK: - Output
    
    func reloadUser(_ user: User) {
        DispatchQueue.main.async {
            self.delegate?.reloadUser(user)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
    
    func finishDeletion() {
        DispatchQueue.main.async {
            self.delegate?.successfullyDeleteUser()
        }
    }
}
