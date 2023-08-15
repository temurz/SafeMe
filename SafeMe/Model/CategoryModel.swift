//
//  CategoryModel.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import Foundation

struct Category: Decodable {
    let id: Int
    let title: String
    let type: String
    let icon: String?
    let status: Bool
}

struct CategoryParsingModel: Decodable {
//    let succes: Bool
//    let message: String
    let body: [Category]
}

