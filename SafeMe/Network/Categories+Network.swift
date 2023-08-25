//
//  Categories+Network.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

extension Network {
    
    func getCategories(type: String, completion: @escaping (StatusCode, [Category]?) -> ()) {
        let api = Api.categories
        
        let params = [["key": "type",
                       "value": type,
                       "type": "text"
                    ]]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: CategoryParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
