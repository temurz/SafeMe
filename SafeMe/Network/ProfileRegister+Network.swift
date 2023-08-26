//
//  ProfileRegister+Network.swift
//  SafeMe
//
//  Created by Temur on 09/08/2023.
//

import Foundation

extension Network {
    
    func getRegions(page: Int, size: Int, completion: @escaping (StatusCode, [Region]?) -> ()) {
        
        let api = Api.regions
        
        let queryItems = [URLQueryItem(name: "size", value: "\(size)")]
        var urlComponents = URLComponents(string: api.path)!
        urlComponents.queryItems = queryItems
        let newUrl = urlComponents.url!
        
        push(api: api,newUrl: newUrl, body: nil, headers: nil, type: RegionParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getDistricts(region: Int, page: Int, size: Int, completion: @escaping (StatusCode, [District]?) -> ()) {
        
        let api = Api.districts
        
        let parameters = [
            ["key": "region",
             "value": "\(region)",
             "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: DistrictParsingModel.self
        ) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getMahallas(region: Int, district: Int, page: Int, size: Int, completion: @escaping (StatusCode, [Mahalla]?) -> ()) {
        let api = Api.mahalla
        
        let parameters = [
            ["key": "district",
             "value": "\(district)",
             "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: MahallaParsingModel.self
        ) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
