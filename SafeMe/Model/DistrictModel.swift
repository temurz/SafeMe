//
//  DistrictModel.swift
//  SafeMe
//
//  Created by Temur on 09/08/2023.
//

import Foundation

struct Region: Codable {
    let id: Int
    let name: String?
}

struct District: Codable {
    let id: Int
    let name: String?
    let region: Int
}
 
struct Mahalla: Codable {
    let id: Int
    let name: String?
    let region: Int
    let district: Int
}


struct RegionParsingModel: Codable {
    let body: [Region]
}

struct DistrictParsingModel: Codable {
    let body: [District]
}

struct MahallaParsingModel: Codable {
    let body: [Mahalla]
}
