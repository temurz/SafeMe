//
//  InspectorsPresenter.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation
import UIKit

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
            self?.delegate?.indicatorView.stopAnimating()
            guard let inspectors = inspectors else {
                self?.pushAlert(statusCode)
                return
            }
            
            self?.reloadInspectors(inspectors)
        }
    }
    
    func call(_ number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func telegram() {
        let appURL = NSURL(string: "tg://resolve?domain=")! as URL
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        }else if let webURL = URL(string: "https://t.me/"), UIApplication.shared.canOpenURL(webURL) {
            UIApplication.shared.open(webURL)
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
