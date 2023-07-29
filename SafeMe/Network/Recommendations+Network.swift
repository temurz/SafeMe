//
//  Recommendations+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getRecommendations(completion: @escaping (StatusCode, [Recommendation]?) -> ()) {
        let api = Api.recommendations
        push(api: api, body: nil, headers: nil, type: RecommendationParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
