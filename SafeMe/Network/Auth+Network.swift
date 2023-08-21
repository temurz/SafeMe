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
        push(false, api: api, body: body, headers: header, type: AuthToken.self) { result in
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
    
    func register(username:String, password:String, repeatPassword: String, completion: @escaping (StatusCode, String?) -> ()) {
        let api = Api.register
        
        
        let parameters = [
            [
                "key": "phone",
                "value": username,
                "type": "text"
            ],
            [
                "key": "password1",
                "value": password,
                "type": "text"
            ],
            [
                "key": "password2",
                "value": repeatPassword,
                "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(false, api: api, body: body, headers: header, type: ParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0, message: model.message), model.body.session_id)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    
    func checkPhoneVerificationCode(code: String, session_id: String, completion: @escaping (StatusCode) -> ()) {
        
        let api = Api.phoneVerification
        
        struct ParsingModel: Decodable {
            let message: String
            let body: BodyModel?
        }
        
        struct BodyModel: Decodable {
            let token: String
            let refresh: String
        }
        
        let parameters = [
            [ "key": "verification_code",
              "value": code,
              "type" : "text"
            ],
            ["key": "session_id",
             "value": session_id,
             "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(false, api: api, body: body, headers: header, type: ParsingModel.self) { result in
            switch result {
            case .success(let model):
                guard let token = model.body?.token, let refresh = model.body?.refresh else {
                    completion(StatusCode(code: 403, message: model.message))
                    return
                }
                let auth = AuthApp.shared
                auth.token = token
                auth.tokenRefresh = refresh
                completion(StatusCode(code: 0, message: model.message))
            case .failure(let error):
                completion(error)
            }
        }
    }
}
