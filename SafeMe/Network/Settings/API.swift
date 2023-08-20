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
    case sos
    case saveAnswer
    case poll
    case pollAnswers
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
        case .register, .login, .sendComplaint, .phoneVerification, .authRefresh, .saveAnswer, .sos:
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
        
        get {
            var baseURL:String {return Base.BASE_URL}
            var lang: String { return AuthApp.shared.language } //ru en uz uz-Cyrl
            var languageUrl = lang == "uz-Cyrl" ? "/sr" : "/" + lang
            
            switch self {
            case .sos: return baseURL + languageUrl + "/api/v1.0/sos/"
            case .saveAnswer: return baseURL + languageUrl + "/api/v1.0/polling/answer"
            case .poll: return baseURL + languageUrl + "/api/v1.0/polling/all"
            case .pollAnswers: return baseURL + languageUrl + "/api/v1.0/polling/view/"
            case .mahalla: return baseURL + languageUrl + "/api/v1.0/mahalla/"
            case .districts: return baseURL + languageUrl + "/api/v1.0/districts/"
            case .regions: return baseURL + languageUrl + "/api/v1.0/regions/"
            case .phoneVerification: return baseURL + languageUrl + "/user/verification/"
            case .getUser: return baseURL + languageUrl + "/user/"
            case .games: return baseURL + languageUrl + "/api/v1.0/games/"
            case .recommendations: return baseURL + languageUrl + "/api/v1.0/recommendation/"
            case .categories: return baseURL + languageUrl + "/api/v1.0/category/"
            case .news: return baseURL + languageUrl + "/api/v1.0/news/"
            case .inspectors: return baseURL + languageUrl + "/api/v1.0/police/"
            case .register: return baseURL + languageUrl + "/user/signup/"
            case .editUser: return baseURL + languageUrl + "/user/update/"
            case .login: return baseURL + languageUrl + "/user/login/"
            case .authRefresh: return baseURL + languageUrl + "/user/token/refresh/"
            case .ageCategory: return baseURL + languageUrl + "/api/v1.0/agecategory/"
            case .sendComplaint: return baseURL + languageUrl + "/api/v1.0/murojaat/"
            }
        }
        
        set {
            
        }
    }
}
