//
//  InspectorsPresenter.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

protocol InspectorsPresenterProtocol: AnyObject {
    func reloadData(inspectors: [Inspector])
}

typealias InspectorsPresenterDelegate = InspectorsPresenterProtocol & InspectorsViewController

class InspectorsPresenter {
    private var inspectors: [Inspector] = [Inspector]()
    weak var delegate: InspectorsPresenterDelegate?
    
    func getInspectors() {
        delegate?.indicatorView.startAnimating(.download)
        
        Network.shared.getInspectors() { [weak self] statusCode, inspectors in
            let text = statusCode.message ?? "Not founded"
            self?.delegate?.indicatorView.stopAnimating()
            guard let inspectors = inspectors else {
                self?.pushAlert(statusCode)
                return
            }
            
            self?.reloadInspectors(inspectors)
        }
    }
}


extension InspectorsPresenter {
    //MARK: Input
    
    //MARK: Output
    
    private func reloadInspectors(_ inspectors: [Inspector]) {
        DispatchQueue.main.async {
            self.delegate?.reloadData(inspectors: inspectors)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }

    }
}
