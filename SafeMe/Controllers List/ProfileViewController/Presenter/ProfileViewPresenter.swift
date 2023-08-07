//
//  ProfileViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 06/08/2023.
//

import Foundation

protocol ProfileViewPresenterProtocol {
    func reloadUser(_ user: User)
}

typealias ProfileViewPresenterDelegate = ProfileViewPresenterProtocol & ProfileViewController

class ProfileViewPresenter {
    weak var delegate: ProfileViewPresenterDelegate?
    
    
    func getUser() {
        delegate?.indicatorView.startAnimating()
        Network.shared.getUser { [weak self] statusCode, user in
            self?.delegate?.indicatorView.stopAnimating()
            
            guard let user else {
                return
            }
            
            self?.reloadUser(user)
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
}
