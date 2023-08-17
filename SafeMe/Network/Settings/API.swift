//
//  API.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

struct Base {
//    static let BASE_URL = "https://cyberpolice.uz"
    static let BASE_URL = "https://back.cyberpolice.uz"
}

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum Api {
    case regions
    case districts
    case mahalla
    case phoneVerification
    case login
    case register
    case editUser
    case authRefresh
    case inspectors
    case news
    case ageCategory
    case categories
    case recommendations
    case games
    case getUser
    case sendComplaint
    
    //MARK: - METHOD
    var method: String {
        switch self {
        case .register, .login, .sendComplaint, .phoneVerification, .authRefresh:
            return HTTPMethod.post.rawValue
        case .editUser:
            return HTTPMethod.put.rawValue
        case .games, .inspectors, .news, .ageCategory, .categories, .recommendations, .getUser:
            return HTTPMethod.get.rawValue
        default:
            return HTTPMethod.get.rawValue
        }
    }
    
    //MARK: - PATH
    var path:String {
        var baseURL:String {return Base.BASE_URL}
            
        switch self {
        case .mahalla: return baseURL + "/uz/api/v1.0/mahalla/"  
        case .districts: return baseURL + "/uz/api/v1.0/districts/"
        case .regions: return baseURL + "/ru/api/v1.0/regions/"
        case .phoneVerification: return baseURL + "/uz/user/verification/"
        case .getUser: return baseURL + "/uz/user/"
        case .games: return baseURL + "/ru/api/v1.0/games/"
        case .recommendations: return baseURL + "/uz/api/v1.0/recommendation/"
        case .categories: return baseURL + "/sr/api/v1.0/category/"
        case .news: return baseURL + "/ru/api/v1.0/news/"
        case .inspectors: return baseURL + "/uz/api/v1.0/police/"
        case .register: return baseURL + "/uz/user/signup/"
        case .editUser: return baseURL + "/uz/user/update/"
        case .login: return baseURL + "/uz/user/login/"
        case .authRefresh: return baseURL + "/uz/user/token/refresh/"
        case .ageCategory: return baseURL + "/uz/api/v1.0/agecategory/"
        case .sendComplaint: return baseURL + "/ru/api/v1.0/murojaat/"
        }
    }
}
