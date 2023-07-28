//
//  AuthDataModel.swift
//  SafeMe
//
//  Created by Temur on 22/07/2023.
//

import Foundation

struct AuthData: Codable {
    let username: String
    let password: String
}

struct Body: Decodable {
    let token: String
    let refresh: String
}

enum FilterStatus {
    case open
    case closed
}

struct AuthToken:Decodable {
    let success: Bool
    let message: String?
    let body: Body?
//    let code: Int
}
