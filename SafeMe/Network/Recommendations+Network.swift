//
//  Recommendations+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getRecommendations(ageCategory: Int?, category: Int?, completion: @escaping (StatusCode, [Recommendation]?) -> ()) {
        var params: [[String: String]]? = nil
        
        var api = Api.recommendations
        if let ageCategory = ageCategory, let category = category  {
            api = Api.recomCategoryAndAge
            params = [[ "key": "agecategory",
                        "value": "\(ageCategory)",
                        "type": "text"
                      ],
                      [ "key": "category",
                        "value": "\(category)",
                        "type": "text"
                      ]]
        }else if let ageCategory = ageCategory {
            api = Api.recomAgeCategory
            params = [[ "key": "agecategory",
                        "value": "\(ageCategory)",
                        "type": "text"
                      ]]
        }else if let category = category {
            api = Api.recomCategory
            params = [[ "key": "category",
                        "value": "\(category)",
                        "type": "text"
                      ]]
        }
        
        if params == nil  {
            push(api: api, body: nil, headers: nil, type: RecommendationParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 200), model.body)
                case .failure(let error):
                    completion(error, nil)
                }
            }
        }else if let params = params {
            let boundary = generateBoundaryString()
            let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
            let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
            push(api: api, body: body, headers: header, type: RecommendationParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 200), model.body)
                case .failure(let error):
                    completion(error, nil)
                }
            }
        }
    }
}
