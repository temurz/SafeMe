//
//  ChatPresenter.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

protocol ChatPresenterProtocol {
    func reloadAgeCategories(_ ageCategories: [AgeCategory])
    func reloadCategories(_ categories: [Category])
    func reloadGames(_ games: [Game], totalPages: Int)
}

typealias ChatPresenterDelegate = ChatPresenterProtocol & ChatViewController

class ChatPresenter {
    weak var delegate: ChatPresenterDelegate?
    
    var selectedAgeCategory: AgeCategory?
    var selectedCategory: Category?
    var games = [Game]()
    
    func getAgeCategories() {
        self.delegate?.indicatorView.startAnimating(.download)
        Network.shared.getAgeCategories { [weak self] statusCode, ageCategories in
            self?.delegate?.indicatorView.stopAnimating()
            guard let ageCategories else {
                self?.pushAlert(statusCode)
                return
            }
            
            self?.reloadAgeCategories(ageCategories)
        }
    }
    
    func getCategories() {
        self.delegate?.indicatorView.startAnimating()
        Network.shared.getCategories(type: "game") { [weak self] statusCode, categories in
            self?.delegate?.indicatorView.stopAnimating()
            guard let categories else {
                return
            }
            
            self?.reloadCategories(categories)
        }
    }
    
    func getGames(ageCategory: AgeCategory? = nil, category: Category? = nil, page: Int, size: Int = 10) {
        self.selectedAgeCategory = ageCategory
        self.selectedCategory = category
        
        self.delegate?.indicatorView.startAnimating()
        
        if !self.games.isEmpty {
            self.delegate?.indicatorView.stopAnimating()
            self.reloadGames(games, totalPages: 1)
        }else {
            Network.shared.getGames(ageCategory: ageCategory?.id, category: category?.id, page: page, size: size) { [weak self] statusCode, games, totalPages in
                self?.delegate?.indicatorView.stopAnimating()
                guard let games else {
                    self?.pushAlert(statusCode)
                    self?.reloadGames([], totalPages: 1)
                    return
                }
                
                self?.reloadGames(games, totalPages: totalPages ?? 1)
            }
        }
        
    }
    
}

extension ChatPresenter {
    
    
    //MARK: Output
    private func reloadAgeCategories(_ ageCategories: [AgeCategory]) {
        DispatchQueue.main.async {
            self.delegate?.reloadAgeCategories(ageCategories)
        }
    }
    
    private func reloadCategories(_ categories: [Category]) {
        DispatchQueue.main.async {
            self.delegate?.reloadCategories(categories)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
    
    private func reloadGames(_ games: [Game], totalPages: Int) {
        DispatchQueue.main.async {
            self.delegate?.reloadGames(games, totalPages: totalPages)
        }
    }
}
