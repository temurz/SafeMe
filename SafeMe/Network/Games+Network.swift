//
//  Games+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getGames(ageCategory: Int?, category: Int?, page: Int, size: Int, completion: @escaping (StatusCode, [Game]?, Int?) -> ()) {
        
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
        
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "size", value: "\(size)")]
        var urlComps = URLComponents(string: api.path)!
        urlComps.queryItems = queryItems
        let newUrl = urlComps.url!
        
        if params == nil  {
            push(api: api,newUrl: newUrl, body: nil, headers: nil, type: GameParsingModel.self) { result in
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
            push(api: api, newUrl: newUrl, body: body, headers: header, type: GameParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 200), model.body, model.total_pages)
                case .failure(let error):
                    completion(error, nil, nil)
                }
            }
        }
    }
    
    
    func getGamesUnbookmarkView(isBookmark: Bool,ageCategory: Int?, category: Int?, page: Int, size: Int, completion: @escaping (StatusCode, [Game]?) -> ()) {
        let api = isBookmark ? Api.gamesBookmarkView : Api.gamesUnbookmarkView
        
        var params: [[String: String]]? = nil
        var queryItems: [URLQueryItem]? = nil
        var newUrl: URL? = nil
        if let ageCategory = ageCategory, let category = category {
            params = [[ "key": "agecategory",
                        "value": "\(ageCategory)",
                        "type": "text"
                      ],
                      [ "key": "category",
                        "value": "\(category)",
                        "type": "text"
                      ]]
            queryItems = [URLQueryItem(name: "agecategory", value: "\(ageCategory)"), URLQueryItem(name: "category", value: "\(category)")]
        }else if let ageCategory = ageCategory {
            params = [[ "key": "agecategory",
                        "value": "\(ageCategory)",
                        "type": "text"
                      ]]
            queryItems = [URLQueryItem(name: "agecategory", value: "\(ageCategory)")]
        }else if let category = category {
            params = [[ "key": "category",
                        "value": "\(category)",
                        "type": "text"
                      ]]
            queryItems = [URLQueryItem(name: "category", value: "\(category)")]
        }
        
        if isBookmark, let queryItems = queryItems {
            var urlComps = URLComponents(string: api.path)!
            urlComps.queryItems = queryItems
            newUrl = urlComps.url!
            push(api: api, newUrl: newUrl , body: nil, headers: nil, type: GameParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 0), model.body)
                case .failure(let error):
                    completion(error, nil)
                }
            }
        }else {
            let boundary = generateBoundaryString()
            let body = generateMutableData(boundary: boundary, parameters: params ?? [[:]], imagesData: []) as Data
            let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
            
            push(api: api, body: body, headers: header, type: GameParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 0), model.body)
                case .failure(let error):
                    completion(error, nil)
                }
            }
        }
    }
    
    func saveOrDeleteGameBookmark(isSave: Bool, game: Int, completion: @escaping (StatusCode) -> ()) {
        let api = isSave ? Api.gamesSave : Api.gamesDelete
        
        let parameters = [["key": "games",
                           "value": "\(game)",
                           "type": "text"]]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: Parsing.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0, message: model.message))
            case .failure(let error):
                completion(error)
            }
        }
    }
}
