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
            [ "key": "birth_day",
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
    
    func deleteUser(userId: Int, completion: @escaping (StatusCode) -> ()) {
        let api = Api.deleteUser
        
        let newUrl = api.path + "\(userId)"
        
        push(api: api, newUrl: URL(string: newUrl) ,body: nil, headers: nil, type: Parsing.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0, message: model.message))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func addChild(name: String, gender: String, date_birthday: String, type_parent: String, completion: @escaping (StatusCode) -> ()) {
        let api = Api.addChild
        
        let params = [
            ["key": "name",
             "value": name,
             "type": "text"
            ],
            ["key": "gender",
             "value": gender, //gender
             "type": "text"
            ],
            ["key": "date_brithday",
             "value": date_birthday, // dat_birthday
             "type": "text"
            ],
            ["key": "type_parrent",
             "value": type_parent, //type_parent
             "type": "text"
            ],
            ["key": "status",
             "value": "True",
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
