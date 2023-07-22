//
//  API.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation

struct Base {
    static let BASE_URL = "http://cyberpolice.uz/"
}

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delate = "DELETE"
}

enum Api {
    case login
    case register
    case editUser
    case authRefresh
    
    //MARK: - METHOD
    var method: String {
        switch self {
        case .register, .login:
            return HTTPMethod.post.rawValue
        case .editUser:
            return HTTPMethod.put.rawValue
        default:
            return HTTPMethod.get.rawValue
        }
    }
    
    //MARK: - PATH
    var path:String {
        var api:String {return Base.BASE_URL}
            
        switch self {
        case .register: return api + "uz/user/login/"
        case .editUser: return api + "uz/user/update/"
        case .login: return api + "uz/user/login/"
        case .authRefresh: return api + ""
        }
    }
}
