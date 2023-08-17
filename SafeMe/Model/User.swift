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
    let birth_day: String?
    let gender: String?
    var region: String?
    var district: String?
    var mahalla: String?
    let adress: String?
    let photo: String?
}

struct UserParsingModel: Codable {
    let success: Bool
    let message: String
    let body: User
}

struct UserEdit {
    var fullName: String
    var phone: String?
    var birthday: String
    var gender: String?
    var region: Int?
    var district: Int?
    var mahalla: Int?
    var photo: Data?
}
