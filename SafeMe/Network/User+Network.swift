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
}
