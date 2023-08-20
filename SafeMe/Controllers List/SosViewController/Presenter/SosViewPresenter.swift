//
//  SosViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 20/08/2023.
//

import Foundation
import CoreLocation
protocol SosViewPresenterProtocol {
    
}

typealias SosViewPresenterDelegate = SosViewPresenterProtocol & SosViewController

class SosViewPresenter {
    weak var delegate: SosViewPresenterDelegate?
    
    func sendSosSignal(long: CLLocationDegrees, lat: CLLocationDegrees, type: String) {
        Network.shared.sendSosSignal(long: long as Double, lat: lat as Double, type: type) { statusCode in
            
            self.pushAlert(statusCode)
        }
    }
}

extension SosViewPresenter {
    
    private func pushAlert(_ statusCode: StatusCode) {
        self.delegate?.alert(error: statusCode, action: nil)
    }
}
