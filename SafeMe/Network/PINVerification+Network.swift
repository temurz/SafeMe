//
//  PINVerification+Network.swift
//  SafeMe
//
//  Created by Temur on 23/08/2023.
//

import Foundation

extension Network {
    
    func requestSMSForPIN(completion: @escaping (StatusCode, String?) -> ()) {
        let api = Api.requestSMSForPin
        
        push(api: api, body: nil, headers: nil, type: ParsingModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 0), model.body.session_id)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    
    func checkSMSCodeForPin(code: String, sessionId: String, completion: @escaping (StatusCode) -> ()) {
        let api = Api.pinSmsCodeVerification
        
        let parameters = [
            ["key": "verification_code",
             "value": code,
             "type": "text"
            ],
            ["key": "session_id",
             "value": sessionId,
             "type": "text"
            ]
        ]
        
        let boundary = generateBoundaryString()
        let body = generateMutableData(boundary: boundary, parameters: parameters, imagesData: []) as Data
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
