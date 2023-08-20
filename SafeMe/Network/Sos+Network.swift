//
//  Sos+Network.swift
//  SafeMe
//
//  Created by Temur on 20/08/2023.
//

import Foundation

extension Network {
    
    func sendSosSignal(long: Double, lat: Double, type: String, completion: @escaping (StatusCode) -> ()) {
        let api = Api.sos
        
        let params = [
            [
                "key": "longitude",
                "value": "\(long)",
                "type": "text"
            ],
            [
                "key": "latitude",
                "value": "\(lat)",
                "type": "text"
            ],
            [
                "key": "type",
                "value": type,
                "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type"]
        
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
