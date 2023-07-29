//
//  AgeCategory.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

struct AgeCategory: Decodable {
    let id: Int
    let title: String
    let yearFrom: Int
    let yearTo: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case yearFrom = "year_from"
        case yearTo = "year_to"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.yearFrom = try container.decode(Int.self, forKey: .yearFrom)
        self.yearTo = try container.decode(Int.self, forKey: .yearTo)
    }
}

struct AgeCategoryParsingModel: Decodable {
    let success: Bool
    let message: String
    let body: [AgeCategory]
}
