//
//  User+Network.swift
//  SafeMe
//
//  Created by Temur on 06/08/2023.
//

import Foundation

extension Network {
    
    func getUser(completion: @escaping (StatusCode, User?) -> ()) {
        let api = Api.getUser
        
        push(api: api, body: nil, headers: nil, type: UserParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func updateUser(firstName: String, lastName: String, birthday: String, region: Int?, district: Int?, mahalla: Int?, photo: Data?, completion: @escaping (StatusCode) -> ()) {
        let api = Api.editUser
        
        var params = [
            [ "key": "first_name",
              "value": firstName,
              "type": "text"
            ],
            [ "key": "last_name",
              "value": lastName,
              "type": "text"
            ],
            [ "key": "birthday",
              "value": birthday,
              "type": "text"
            ],
            
        ]
        
        if let region = region {
            params.append([ "key": "region",
                            "value": "\(region)",
                            "type": "text"
                          ])
            
            
        }
        if let district = district {
            params.append([ "key": "district",
                            "value": "\(district)",
                            "type": "text"
                          ])
        }
        if let mahalla = mahalla {
            params.append([ "key": "mahalla",
                            "value": "\(mahalla)",
                            "type": "text"
                          ])
        }
        
        
        let photos = photo != nil ? [photo!] : []
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: params, imagesData: photos) as Data
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
