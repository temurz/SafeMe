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
    case deleteUser
    case requestSMSForPin
    case passwordUpdate
    case addChild
    case sos
    case saveAnswer
    case poll
    case pollWithAge
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
    case recomAgeCategory
    case recomCategory
    case recomCategoryAndAge
    case games
    case gamesUnbookmarkView
    case gamesSave
    case gamesDelete
    case gamesBookmarkView
    case gamesAgeCategory
    case gamesCategory
    case gamesCategoryAndAge
    case getUser
    case sendComplaint
    case requestSMSForPasswordChange
    case checkPasswordSms
    case pinSmsCodeVerification
    
    //MARK: - METHOD
    var method: String {
        switch self {
        case .register, .login, .sendComplaint, .phoneVerification, .authRefresh, .saveAnswer,.requestSMSForPasswordChange, .sos, .checkPasswordSms, .addChild, .passwordUpdate, .pinSmsCodeVerification, .recomCategory, .recomAgeCategory, .recomCategoryAndAge, .gamesCategory, .gamesAgeCategory, .gamesCategoryAndAge, .categories, .pollWithAge, .gamesSave, .gamesUnbookmarkView, .districts, .mahalla:
            return HTTPMethod.post.rawValue
        case .editUser:
            return HTTPMethod.put.rawValue
        case .games, .inspectors, .news, .ageCategory, .recommendations, .getUser:
            return HTTPMethod.get.rawValue
        case .gamesDelete, .deleteUser:
            return HTTPMethod.delete.rawValue
        default:
            return HTTPMethod.get.rawValue
        }
    }
    
    //MARK: - PATH
    var path:String {
        
        get {
            var baseURL:String {return Base.BASE_URL}
            var lang: String { return AuthApp.shared.language } //ru en uz uz-Cyrl
            let languageUrl = lang == "uz-Cyrl" ? "/sr" : "/" + lang
            
            switch self {
            case .deleteUser: return baseURL + languageUrl + "/user/delete/"
            case .pinSmsCodeVerification: return baseURL + languageUrl + "/user/pin/verification"
            case .requestSMSForPin: return baseURL + languageUrl + "/user/pin/recover"
            case .passwordUpdate: return baseURL + languageUrl + "/user/password/update"
            case .addChild: return baseURL + languageUrl + "/user/childern/create/"
            case .checkPasswordSms: return baseURL + languageUrl + "/user/password/verification"
            case .requestSMSForPasswordChange: return baseURL + languageUrl + "/user/password/recover"
            case .sos: return baseURL + languageUrl + "/api/v1.0/sos/"
            case .saveAnswer: return baseURL + languageUrl + "/api/v1.0/polling/answer"
            case .poll: return baseURL + languageUrl + "/api/v1.0/polling/all"
            case .pollWithAge: return baseURL + languageUrl + "/api/v1.0/polling/all"
            case .pollAnswers: return baseURL + languageUrl + "/api/v1.0/polling/view/"
            case .mahalla: return baseURL + languageUrl + "/api/v1.0/mahalla/by_district"
            case .districts: return baseURL + languageUrl + "/api/v1.0/district/by_region"
            case .regions: return baseURL + languageUrl + "/api/v1.0/regions/"
            case .phoneVerification: return baseURL + languageUrl + "/user/verification/"
            case .getUser: return baseURL + languageUrl + "/user/"
            case .games: return baseURL + languageUrl + "/api/v1.0/games/"
            case .gamesUnbookmarkView: return baseURL + languageUrl + "/api/v1.0/games/unbookmark"
            case .gamesBookmarkView: return baseURL + languageUrl + "/api/v1.0/games/bookmark"
            case .gamesSave: return baseURL + languageUrl + "/api/v1.0/games/bookmark"
            case .gamesDelete: return baseURL + languageUrl + "/api/v1.0/games/bookmark"
            case .gamesCategory: return baseURL + languageUrl + "/api/v1.0/games/category"
            case .gamesAgeCategory: return baseURL + languageUrl + "/api/v1.0/games/age"
            case .gamesCategoryAndAge: return baseURL + languageUrl + "/api/v1.0/games/agecategory"
            case .recommendations: return baseURL + languageUrl + "/api/v1.0/recommendation/"
            case .recomCategory: return baseURL + languageUrl + "/api/v1.0/recommendation/category"
            case .recomAgeCategory: return baseURL + languageUrl + "/api/v1.0/recommendation/agecategory"
            case .recomCategoryAndAge: return baseURL + languageUrl + "/api/v1.0/recommendation/agecat"
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
