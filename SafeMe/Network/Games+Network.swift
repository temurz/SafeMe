//
//  Games+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getGames(ageCategory: Int?, category: Int?, completion: @escaping (StatusCode, [Game]?) -> ()) {
        
        var api = Api.games
        var params: [[String: String]]? = nil
        if let ageCategory = ageCategory, let category = category {
            api = Api.gamesCategoryAndAge
            params = [[ "key": "agecategory",
                        "value": "\(ageCategory)",
                        "type": "text"
                      ],
                      [ "key": "category",
                        "value": "\(category)",
                        "type": "text"
                      ]]
        }else if let ageCategory = ageCategory {
            api = Api.gamesAgeCategory
            params = [[ "key": "agecategory",
                         "value": "\(ageCategory)",
                         "type": "text"
                       ]]
        }else if let category = category {
            api = Api.gamesCategory
            params = [[ "key": "category",
                        "value": "\(category)",
                        "type": "text"
                      ]]
        }
        
        if params == nil  {
            push(api: api, body: nil, headers: nil, type: GameParsingModel.self) { result in
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
            push(api: api, body: body, headers: header, type: GameParsingModel.self) { result in
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
