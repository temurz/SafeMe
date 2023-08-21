//
//  PasswordModel.swift
//  SafeMe
//
//  Created by Даулетбай Комекбаев on 21/08/23.
//

import Foundation

struct ParsingModel: Decodable {
    let success: Bool
    let message: String
    let body: BodyModel
}

struct BodyModel: Decodable {
    let session_id: String
}
