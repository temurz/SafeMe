//
//  Recommendations+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getRecommendations(ageCategory: Int?, category: Int?, page: Int, size: Int, completion: @escaping (StatusCode, [Recommendation]?, Int?) -> ()) {
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
        
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "size", value: "\(size)")]
        var urlComps = URLComponents(string: api.path)!
        urlComps.queryItems = queryItems
        let newUrl = urlComps.url!
        
        if params == nil  {
            push(api: api, newUrl: newUrl, body: nil, headers: nil, type: RecommendationParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 200), model.body, model.total_pages)
                case .failure(let error):
                    completion(error, nil, nil)
                }
            }
        }else if let params = params {
            let boundary = generateBoundaryString()
            let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
            let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
            push(api: api, newUrl: newUrl, body: body, headers: header, type: RecommendationParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 200), model.body, model.total_pages)
                case .failure(let error):
                    completion(error, nil, nil)
                }
            }
        }
    }
}
