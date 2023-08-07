//
//  ApplicationsViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 07/08/2023.
//

import Foundation

protocol ApplicationsViewPresenterProtocol {
    
}

typealias ApplicationsViewPresenterDelegate = ApplicationsViewPresenterProtocol & ApplicationsViewController


class ApplicationsViewPresenter {
    weak var delegate: ApplicationsViewPresenterDelegate?
    
    func sendComplaint(type: String, title: String, text: String) {
        delegate?.indicatorView.startAnimating()
        Network.shared.sendComplaint(type: type.lowercased(), title: title, content: text) { [weak self] statusCode in
            self?.delegate?.indicatorView.stopAnimating()
            
            if statusCode.code != 0 {
                self?.pushAlert(statusCode)
            }else {
                self?.pushAlert(statusCode)
            }
            
        }
    }
}

extension ApplicationsViewPresenter {
    
    //MARK: - Output
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }

    }
}
