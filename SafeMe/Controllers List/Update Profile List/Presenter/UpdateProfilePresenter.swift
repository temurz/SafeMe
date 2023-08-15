//
//  UpdateProfilePresenter.swift
//  SafeMe
//
//  Created by Temur on 09/08/2023.
//

import Foundation

protocol UpdateProfilePresenterProtocol {
    func updateRegions(regions: [Region])
}

typealias UpdateProfilePresenterDelegate = UpdateProfilePresenterProtocol & UpdateProfileViewController

class UpdateProfilePresenter {
    weak var delegate: UpdateProfilePresenterDelegate?
    func getRegions(page: Int, size: Int) {
        Network.shared.getRegions(page: page, size: size) { statusCode, regions in
            
            guard let regions else {
                self.pushAlert(statusCode)
                return
            }
            
            self.updateRegions(regions)
            
        }
    }
    
    func getDistricts(region: Int, page: Int, size: Int) {
        Network.shared.getDistricts(region: region, page: page, size: size) { statusCode, districts in
            guard let districts else {
                self.pushAlert(statusCode)
                return
            }
            self.updateDistricts(districts)
        }
    }
    
    func getMahallas(region: Int, district: Int, page: Int, size: Int) {
        Network.shared.getMahallas(region: region, district: district, page: page, size: size) { statusCode, mahallas in
            guard let mahallas else {
                self.pushAlert(statusCode)
                return
            }
            self.updateMahallas(mahallas)
        }
    }
    
    func sendUserData() {
        
    }
}

extension UpdateProfilePresenter {
    
    private func updateRegions(_ regions: [Region]) {
        DispatchQueue.main.async {
            self.delegate?.updateRegions(regions: regions)
        }
    }
    
    private func updateDistricts(_ districts: [District]) {
        DispatchQueue.main.async {
            self.delegate?.updateDistricts(districts: districts)
        }
    }
    
    private func updateMahallas(_ mahallas: [Mahalla]) {
        DispatchQueue.main.async {
            self.delegate?.updateMahallas(mahallas: mahallas)
        }
    }
    
    private func pushAlert(_ error: StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
}
