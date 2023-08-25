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
    func reloadGames(_ games: [Game])
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
        Network.shared.getCategories { [weak self] statusCode, categories in
            self?.delegate?.indicatorView.stopAnimating()
            guard let categories else {
                return
            }
            
            self?.reloadCategories(categories)
        }
    }
    
    func getGames(ageCategory: AgeCategory? = nil, category: Category? = nil) {
        self.selectedAgeCategory = ageCategory
        self.selectedCategory = category
        
        self.delegate?.indicatorView.startAnimating()
        
        if !self.games.isEmpty {
            self.delegate?.indicatorView.stopAnimating()
            self.reloadGames(games)
        }else {
            Network.shared.getGames(ageCategory: ageCategory?.id, category: category?.id) { [weak self] statusCode, games in
                self?.delegate?.indicatorView.stopAnimating()
                guard let games else {
                    self?.pushAlert(statusCode)
                    self?.reloadGames([])
                    return
                }
                
                self?.reloadGames(games)
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
            let filteredItems = categories.filter({$0.type == "game"})
            self.delegate?.reloadCategories(filteredItems)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
    
    private func reloadGames(_ games: [Game]) {
        DispatchQueue.main.async {
//            var filteredGames = games
//            if let selectedAgeCategory = self.selectedAgeCategory {
//                filteredGames = games.filter({$0.agecategory == selectedAgeCategory.id})
//            }
//            if let selectedCategory = self.selectedCategory {
//                filteredGames = filteredGames.filter({$0.category == selectedCategory.id})
//            }
            self.delegate?.reloadGames(games)
        }
    }
}
