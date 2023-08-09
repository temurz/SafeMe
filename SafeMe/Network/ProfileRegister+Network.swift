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
        
        
        push(api: api, body: nil, headers: nil, type: RegionParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
        
        
    }
}
