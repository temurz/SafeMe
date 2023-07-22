//
//  ResultNetwork.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

enum Result<Model> {
    case success(model: Model)
    case failure(error: StatusCode)
}
