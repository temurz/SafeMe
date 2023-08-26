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
    func successSaveOrDeleteBookmark()
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
    
    func getGamesBookmarkView(isBookmark: Bool, ageCategory: Int?, category: Int?) {
        Network.shared.getGamesUnbookmarkView(isBookmark: isBookmark, ageCategory: ageCategory, category: category, page: 1, size: 10) { [weak self] statusCode, games in
            guard let games else {
                self?.pushAlert(statusCode)
                self?.reloadGames([], totalPages: 1)
                return
            }
            self?.reloadGames(games, totalPages: 1)
        }
    }
    
    func saveOrDeleteGameBookmark(game: Int, isSave: Bool) {
        Network.shared.saveOrDeleteGameBookmark(isSave: isSave, game: game) { statusCode in
            
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            self.successSaveOrDeleteGame()
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
    
    private func successSaveOrDeleteGame() {
        DispatchQueue.main.async {
            self.delegate?.successSaveOrDeleteBookmark()
        }
    }
}
