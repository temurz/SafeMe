//
//  Complaint+Network.swift
//  SafeMe
//
//  Created by Temur on 07/08/2023.
//

import Foundation

extension Network {
    
    func sendComplaint(type: String, title: String, content: String, completion: @escaping (StatusCode) -> ()) {
        
        let api = Api.sendComplaint
        
        let parameters = [
            ["key": "type",
             "value": type,
             "type": "text"
            ],
            ["key": "title",
             "value": title,
             "type": "text"
            ],
            ["key": "text",
             "value": content,
             "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: ComplaintParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0, message: model.message))
            case .failure(let error):
                completion(error)
            }
        }
        
        
    }
}
