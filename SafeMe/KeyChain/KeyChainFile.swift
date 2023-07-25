//
//  KeyChainFile.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation
import Locksmith

class AuthApp {
    static let shared: AuthApp = AuthApp()
    
    private var keyToken:String { "tokenKey" }
    private let keyTokenRefresh = "keyTokenRefreshKey"
    private var keyAuth:String { "MyAutorizationKey"}
    private var keyAppEnterCode: String { "appEnterCodeKey" }
    
    //MARK: Token
    var token:String? {
        get {
            guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: keyToken) else {return nil}
            guard let data = dictionary[keyToken] as? Data else {return nil}
            guard let token = String(data: data, encoding: .utf8) else {return nil}
            return token
        }
        set {
            guard let token = newValue else {return removeToken()}
            do {
                // remove old entry
                removeToken()
                //save new data
                let data = token.data(using: .utf8)!
                try Locksmith.saveData(data: [keyToken: data], forUserAccount: keyToken)
            }
            catch {
                print("error save token")
            }
        }
    }
    
    //MARK: Refresh
    var tokenRefresh:String? {
        get {
            guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: keyTokenRefresh) else {return nil}
            guard let data = dictionary[keyTokenRefresh] as? Data else {return nil}
            guard let token = String(data: data, encoding: .utf8) else {return nil}
            return token
        }
        set {
            guard let token = newValue else {
                guard  ((try? Locksmith.deleteDataForUserAccount(userAccount: keyTokenRefresh)) != nil) else {return }
                return
            }
            do {
                // remove old entry
                removeRefresh()
                //save new data
                let data = token.data(using: .utf8)!
                try Locksmith.saveData(data: [keyTokenRefresh: data], forUserAccount: keyTokenRefresh)
            }
            catch {
                print("error save token")
            }
        }
    }
    
    //MARK: login end password
    var autorization: AuthData? {
        get {
            guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: keyAuth) else {return nil}
            guard let data = dictionary[keyAuth] as? Data else {return nil}
            guard let object = try? JSONDecoder().decode(AuthData.self, from: data) else {return nil}
            return object
        }
        set {
            guard let newValue = newValue else {
                removeAutorization()
                removeToken()
                return
            }
            do {
                // remove old entry
                removeAutorization()
                //save new data
                guard let data = try? JSONEncoder().encode(newValue) else {return}
                try Locksmith.saveData(data: [keyAuth: data], forUserAccount: keyAuth)
            }
            catch {
                print("error save token")
            }
        }
    }
    
    var appEnterCode: String? {
        get {
            UserDefaults.standard.string(forKey: keyAppEnterCode)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: keyAppEnterCode)
        }
    }
    
    //MARK: - Token Action
    func removeTokens() {
        guard  ((try? Locksmith.deleteDataForUserAccount(userAccount: keyToken)) != nil) else {return }
        guard  ((try? Locksmith.deleteDataForUserAccount(userAccount: keyTokenRefresh)) != nil) else {return }
    }
    
    private func removeToken() {
        guard  ((try? Locksmith.deleteDataForUserAccount(userAccount: keyToken)) != nil) else {return }
    }
    
    private func removeRefresh() {
        guard  ((try? Locksmith.deleteDataForUserAccount(userAccount: keyTokenRefresh)) != nil) else {return }
    }
    
    private func removeAutorization() {
        guard  ((try? Locksmith.deleteDataForUserAccount(userAccount: keyAuth)) != nil) else {return}
    }
    
    //MARK: - Language
    var language: String {
        get {
            return UserDefaults.standard.string(forKey: "LanguageTypeKey") ?? "uz"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "LanguageTypeKey")
            UserDefaults.standard.synchronize()
        }
    }
}
