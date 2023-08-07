//
//  ComplaintModel.swift
//  SafeMe
//
//  Created by Temur on 07/08/2023.
//

import Foundation

struct Complaint: Codable {
    let type: String
    let title: String
    let text: String
}

struct ComplaintParsingModel: Decodable {
    let success: Bool
    let message: String?
}
