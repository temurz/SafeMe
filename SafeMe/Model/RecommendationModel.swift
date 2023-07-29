//
//  RecommendationModel.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

struct Recommendation: Decodable {
    let id: Int
    let title: String
    let category: Int
    let ageCategory: Int
    let image: String
    let shortText: String
    let text: String
    let createdDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, category, ageCategory = "agecategory", image,
             shortText = "shorttext", text, createdDate = "created_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decode(Int.self, forKey: .category)
        self.ageCategory = try container.decode(Int.self, forKey: .ageCategory)
        self.image = try container.decode(String.self, forKey: .image)
        self.shortText = try container.decode(String.self, forKey: .shortText)
        self.text = try container.decode(String.self, forKey: .text)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
    }
}

struct RecommendationParsingModel: Decodable {
    let body: [Recommendation]
}
