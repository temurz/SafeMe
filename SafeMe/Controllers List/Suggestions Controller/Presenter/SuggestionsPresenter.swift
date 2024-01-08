//
//  SuggestionsPresenter.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import Foundation

protocol SuggestionsPresenterProtocol {
    func reloadAgeCategories(_ ageCategories: [AgeCategory])
    func reloadCategories(_ categories: [Category])
    func reloadRecommendations(_ recommendations: [Recommendation], totalPages: Int)
}

typealias SuggestionsPresenterDelegate = SuggestionsPresenterProtocol & SuggestionsViewController

class SuggestionsPresenter {
    weak var delegate: SuggestionsPresenterDelegate?
    
    var selectedAgeCategory: AgeCategory?
    var selectedCategory: Category?
    var size: Int = 10
    var recommendations: [Recommendation] = []
    
    func getAgeCategories() {
        self.delegate?.indicatorView.startAnimating(.download)
        Network.shared.getAgeCategories { [weak self] statusCode, ageCategories in
            self?.delegate?.indicatorView.stopAnimating()
            guard let ageCategories else {
//                self?.pushAlert(statusCode)
                return
            }
            
            self?.reloadAgeCategories(ageCategories)
        }
    }
    
    func getCategories(type: String) {
        self.delegate?.indicatorView.startAnimating()
        Network.shared.getCategories(type: type) { [weak self] statusCode, categories in
            self?.delegate?.indicatorView.stopAnimating()
            guard let categories else {
                return
            }
            
            self?.reloadCategories(categories)
        }
    }
    
    func getRecommendations(ageCategory: AgeCategory? = nil, category: Category? = nil, page: Int, size: Int = 10) {
        self.selectedAgeCategory = ageCategory
        self.selectedCategory = category
        self.size = size
        
        if !self.recommendations.isEmpty {
            self.delegate?.indicatorView.stopAnimating()
            self.reloadRecommendations(recommendations, totalPages: 0)
        }else {
            Network.shared.getRecommendations(ageCategory: ageCategory?.id, category: category?.id, page: page, size: size) { [weak self] statusCode, recommendations, totalPages in
                guard let recommendations else {
//                    self?.pushAlert(statusCode)
                    self?.reloadRecommendations([], totalPages: 1)
                    return
                }
                self?.reloadRecommendations(recommendations, totalPages: totalPages ?? 1)
            }
        }
    }
}

extension SuggestionsPresenter {
    
    
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
    
    private func reloadRecommendations(_ recommendations: [Recommendation], totalPages: Int) {
        DispatchQueue.main.async {
            self.delegate?.reloadRecommendations(recommendations, totalPages: totalPages)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
}
