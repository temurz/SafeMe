//
//  NewsModel.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import Foundation

struct News: Decodable {
    let id: Int
    let title: String
    let category: Int
    let shortText: String
    let content: String
    let image: String
    let createdDate: String
    let views: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case category
        case shortText = "shorttext"
        case content
        case image
        case createdDate = "created_date"
        case views
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decode(Int.self, forKey: .category)
        self.shortText = try container.decode(String.self, forKey: .shortText)
        self.content = try container.decode(String.self, forKey: .content)
        self.image = try container.decode(String.self, forKey: .image)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.views = try container.decode(Int.self, forKey: .views)
    }
}

struct NewsModel: Decodable {
//    let next: String?
//    let previous: String?
//    let count: Int
    let totalPages: Int?
    let body: [News]
    
    enum CodingKeys: String, CodingKey {
//        case next
//        case previous
//        case count
        case totalPages = "total_pages"
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.next = try container.decode(String.self, forKey: .next)
//        self.previous = try container.decode(String.self, forKey: .previous)
//        self.count = try container.decode(Int.self, forKey: .count)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.body = try container.decode([News].self, forKey: .body)
    }
}
