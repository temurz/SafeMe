//
//  PollModel.swift
//  SafeMe
//
//  Created by Temur on 17/08/2023.
//

import Foundation

struct PollingModel: Decodable {
    let id: Int
    let type: String
    let text: String
    let media: String
    let ageCategory: Int
    let createdDate: String
    let status: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id, type, text, media, ageCategoty = "agecategory", createdDate = "created_date", status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.text = try container.decode(String.self, forKey: .text)
        self.media = try container.decode(String.self, forKey: .media)
        self.ageCategory = try container.decode(Int.self, forKey: .ageCategoty)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.status = try container.decode(Bool.self, forKey: .status)
    }
}

struct PollingParsingModel: Decodable {
    let success: Bool
    let message: String
    let body: [PollingModel]
}


struct Answer: Decodable {
    let id: Int
    let text: String
}

struct PollAnswerModel: Decodable {
    let id: Int
    let type: String
    let text: String
    let media: String
    let agecategory: Int
    let created_date: String
    let result: [Answer]
}

struct PollAnswerParsingModel: Decodable {
    
    let success: Bool
    let message: String
    let body: PollAnswerModel
}


