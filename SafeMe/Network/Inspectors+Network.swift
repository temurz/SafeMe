//
//  Inspectors+Network.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

extension Network {
    //MARK: Get the inspectors
    func getInspectors(mahalla: Int, completion: @escaping (StatusCode, [Inspector]?) -> ()) {
        
        //Api
        let api = Api.inspectors
        
        //Body
        let parameters = [
            ["key": "mahalla",
             "value": "\(mahalla)",
             "type": "text"
            ]] as [[String: String]]
        
        //Header
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: nil, headers: nil, type: InspectorsModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
