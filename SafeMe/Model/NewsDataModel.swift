//
//  NewsModel.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import Foundation

struct News: Decodable {
    let id: Int
    let title: String?
    let category: Int?
    let shorttext: String?
    let content: String?
    let image: String?
    let created_date: String?
    let views: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case category
//        case shorttext = "shorttext"
//        case content
//        case image
//        case created_date = "created_date"
//        case views
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.title = try container.decode(String.self, forKey: .title)
//        self.category = try container.decode(Int.self, forKey: .category)
//        self.shorttext = try container.decode(String.self, forKey: .shorttext)
//        self.content = try container.decode(String.self, forKey: .content)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.created_date = try container.decode(String.self, forKey: .created_date)
//        self.views = try container.decode(Int.self, forKey: .views)
//    }
}

struct NewsModel: Decodable {
//    let next: String?
//    let previous: String?
//    let count: Int?
    let total_pages: Int?
    let body: [News]
    
//    enum CodingKeys: String, CodingKey {
////        case next
////        case previous
////        case count
////        case total_pages = "total_pages"
//        case body
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
////        self.next = try container.decode(String.self, forKey: .next)
////        self.previous = try container.decode(String.self, forKey: .previous)
////        self.count = try container.decode(Int.self, forKey: .count)
////        self.total_pages = try container.decode(Int.self, forKey: .total_pages)
//        self.body = try container.decode([News].self, forKey: .body)
//    }
}
