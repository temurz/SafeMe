//
//  User.swift
//  SafeMe
//
//  Created by Temur on 06/08/2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let phone: String
    let first_name: String
    let last_name: String
    let birth_day: String
    let gender: String
    let region: String?
    let district: String?
    let mahalla: String?
    let adress: String
    let photo: String
}

struct UserParsingModel: Codable {
    let success: Bool
    let message: String
    let body: User
}
