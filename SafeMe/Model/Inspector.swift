//
//  InspectorModel.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import Foundation

struct Inspector: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let patranomic: String
    let position: String
    let rank: String
    let phone: String
    let image: String
    let region: Int
    let district: Int
    let mahalla: Int
    
    private enum CodingKeys : String, CodingKey {
        case id, firstName = "first_name", lastName = "last_name", patranomic, position = "lavozimi", rank = "unvoni" , phone, image, region, district, mahalla
    }
    
    
    
    init(from decoder: Decoder) throws {
        let keys = try decoder.container(keyedBy: CodingKeys.self)
        id = try keys.decode(Int.self, forKey: .id)
        firstName = try keys.decode(String.self, forKey: .firstName)
        lastName = try keys.decode(String.self, forKey: .lastName)
        patranomic = try keys.decode(String.self, forKey: .patranomic)
        position = try keys.decode(String.self, forKey: .position)
        rank = try keys.decode(String.self, forKey: .rank)
        phone = try keys.decode(String.self, forKey: .phone)
        image = try keys.decode(String.self, forKey: .image)
        region = try keys.decode(Int.self, forKey: .region)
        district = try keys.decode(Int.self, forKey: .district)
        mahalla = try keys.decode(Int.self, forKey: .mahalla)
    }
}

struct Links: Decodable {
    let next: Int?
    let previous: Int?
}

struct InspectorsModel: Decodable {
    let success: Bool
    let message: String
//    let links: Links
//    let page_size: Int
//    let current_page: Int
//    let total_page: Int
    let body: [Inspector]
//    let code: Int
}
