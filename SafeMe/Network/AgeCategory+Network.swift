//
//  AgeCategory+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getAgeCategories(completion: @escaping (StatusCode, [AgeCategory]?) -> ()) {
        
        let api = Api.ageCategory
        
        push(api: api, body: nil, headers: nil, type: AgeCategoryParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
