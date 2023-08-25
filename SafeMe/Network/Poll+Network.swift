//
//  Poll+Network.swift
//  SafeMe
//
//  Created by Temur on 17/08/2023.
//

import Foundation

extension Network {
    
    func getPolls(page: Int, size: Int, ageCategory: Int?, completion: @escaping (StatusCode, [PollingModel]?, Int?) -> ()) {
        
        var api = Api.poll
        
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "size", value: "\(size)")]
        var urlComps = URLComponents(string: api.path)!
        urlComps.queryItems = queryItems
        let newUrl = urlComps.url!
        
        if let ageCategory = ageCategory {
            api = .pollWithAge
            
            let params = [["key": "agecategory",
                           "value": "\(ageCategory)",
                           "type": "text"
                          ]]
            let boundary = generateBoundaryString()
            let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
            let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
            
            push(api: api, body: body, headers: header, type: PollingParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 0), model.body, model.total_pages)
                case .failure(let error):
                    completion(error, nil, nil)
                }
            }
        }else {
            push(api: api, newUrl: newUrl, body: nil, headers: nil, type: PollingParsingModel.self) { result in
                switch result {
                case .success(let model):
                    completion(StatusCode(code: 0), model.body, model.total_pages)
                case .failure(let error):
                    completion(error, nil, nil)
                }
            }
        }
    }
    
    func getPollAnswers(poll_id: Int, completion: @escaping (StatusCode, [Answer]?) -> ()) {
        let api = Api.pollAnswers
        
        let path = URL(string: api.path + "\(poll_id)")
        
        push(api: api,newUrl: path, body: nil, headers: nil, type: PollAnswerParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body.result)
            case .failure(let error):
                completion(error, nil)
            }
        }
        
    }
    
    func saveAnswer(question: Int, answer: Int, completion: @escaping (StatusCode) -> ()) {
        let api = Api.saveAnswer
        let params = [
            [
                "key": "question",
                "value": "\(question)",
                "type": "text"
            ],
            [
                "key": "answer",
                "value": "\(answer)",
                "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
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
