//
//  GameModel.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

struct Game: Decodable {
    let id: Int
    let name: String
    let image: String?
    let agecategory: Int
    let category: Int
    let description: String?
    let recommendation: String
    let developercompany: String
    let created_date: String
    
//    private enum CodingKeys: String, CodingKey {
//        case id, name, ageCategory = "agecategory",
//        category,
//        description,
//        recommendation,
//        developerCompany = "developercompany",
//        createdDate = "created_date"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        agecategory = try container.decode(Int.self, forKey: .ageCategory)
//        category = try container.decode(Int.self, forKey: .category)
//        description = try container.decode(String.self, forKey: .description)
//        recommendation = try container.decode(String.self, forKey: .recommendation)
//        developercompany = try container.decode(String.self, forKey: .developerCompany)
//        created_date = try container.decode(String.self, forKey: .createdDate)
//    }
}

struct GameParsingModel: Decodable {
    let body: [Game]
}
