//
//  Auth+Network.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

extension Network {
    //MARK: - Authorization
    func authorization(username:String, password:String, completion: @escaping (StatusCode) -> ()) {
        
        //Api
        let api:Api = Api.login
        
        //Body
        let parameters = [
            [
                "key": "username",
                "value": username,
                "type": "text"
            ],
            [
                "key": "password",
                "value": password,
                "type": "text"
            ]] as [[String : String]]
        
        
        //Header
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        print(String(data: body, encoding: .utf8)!)
        push(api: api, body: body, headers: header, type: AuthToken.self) { result in
            switch result {
            case .success(let model):
                guard let token = model.body?.token, let refresh = model.body?.refresh else {
                    completion(StatusCode(code: 403, message: model.message))
                    return
                }
                
                let auth = AuthApp.shared
                auth.token = token
                auth.tokenRefresh = refresh
//                auth.autorization = AuthData(username: username, password: password)
//                auth.user = model.result
                completion(StatusCode(code: 0))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    
}
