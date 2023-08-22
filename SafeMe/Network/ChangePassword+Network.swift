//
//  ChangePassword+Network.swift
//  SafeMe
//
//  Created by Даулетбай Комекбаев on 21/08/23.
//

import Foundation

extension Network {
    func requestSMSforChangePassword(phoneNumber: String, completion: @escaping (StatusCode, String?) -> ()) {
        let api = Api.requestSMSForPasswordChange
        
        
        
        let params = [["key":"phone",
                       "value":phoneNumber,
                       "type": "text"
                      ]]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: params, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: ParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body.session_id)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func checkCodeForPasswordChange(code: String, sessionId: String, completion: @escaping (StatusCode, String?) -> ()) {
        
        let api = Api.checkPasswordSms
        
        let parameters = [
            [ "key": "verification_code",
              "value": code,
              "type" : "text"
            ],
            ["key": "session_id",
             "value": sessionId,
             "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
        let header = ["multipart/form-data; boundary=\(boundary)" : "Content-Type" ]
        
        push(api: api, body: body, headers: header, type: ParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body.session_id)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func sendNewPasswords(newPass: String, repeatPass: String, sessionId: String, completion: @escaping (StatusCode) -> ()) {
        let api = Api.passwordUpdate
        
        let params = [
            ["key": "password1",
             "value": newPass,
             "type": "text"
            ],
            ["key": "password2",
             "value": repeatPass,
             "type": "text"
            ],
            ["key": "session_id",
             "value": sessionId,
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
