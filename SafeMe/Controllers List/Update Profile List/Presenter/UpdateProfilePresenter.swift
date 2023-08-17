//
//  UpdateProfilePresenter.swift
//  SafeMe
//
//  Created by Temur on 09/08/2023.
//

import Foundation

protocol UpdateProfilePresenterProtocol {
    func updateRegions(regions: [Region])
    func updateDistricts(districts: [District])
    func updateMahallas(mahallas: [Mahalla])
    func updateUser()
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
    
    func sendUserData(fullName: String, birthday: String , region: Int?, district: Int?, mahalla: Int?, photo: Data?) {
        let names = fullName.components(separatedBy: " ")
        var firstName = ""
        var lastName = ""
        if names.count == 1 {
            firstName = names[0]
        }else if names.count > 1 {
            firstName = names[0]
            lastName = names[1]
        }
        
        Network.shared.updateUser(firstName: firstName, lastName: lastName, birthday: birthday, region: region, district: district, mahalla: mahalla, photo: photo) { statusCode in
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            
            self.updateUser()
        }
    }
}

extension UpdateProfilePresenter {
    
    private func updateRegions(_ regions: [Region]) {
        DispatchQueue.main.async {
            self.delegate?.updateRegions(regions: regions.reversed())
        }
    }
    
    private func updateDistricts(_ districts: [District]) {
        DispatchQueue.main.async {
            self.delegate?.updateDistricts(districts: districts.reversed())
        }
    }
    
    private func updateMahallas(_ mahallas: [Mahalla]) {
        DispatchQueue.main.async {
            self.delegate?.updateMahallas(mahallas: mahallas.reversed())
        }
    }
    
    private func updateUser() {
        DispatchQueue.main.async {
            self.delegate?.updateUser()
        }
    }
    
    private func pushAlert(_ error: StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
}
