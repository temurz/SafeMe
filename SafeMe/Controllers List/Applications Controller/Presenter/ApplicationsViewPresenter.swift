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
                self?.pushAlert(title: "Error".localizedString, message: "Unknown error".localizedString)
            }else {
                self?.pushAlert(title: "Success".localizedString, message: "Successfully sent!".localizedString)
            }
            
        }
    }
}

extension ApplicationsViewPresenter {
    
    //MARK: - Output
    
    private func pushAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.delegate?.alert(title: title, message: message, url: nil)
        }

    }
}
