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
    func reloadRecommendations(_ recommendations: [Recommendation])
}

typealias SuggestionsPresenterDelegate = SuggestionsPresenterProtocol & SuggestionsViewController

class SuggestionsPresenter {
    weak var delegate: SuggestionsPresenterDelegate?
    
    var selectedAgeCategory: AgeCategory?
    var selectedCategory: Category?
    var recommendations: [Recommendation] = []
    
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
    
    func getRecommendations(ageCategory: AgeCategory? = nil, category: Category? = nil) {
        self.selectedAgeCategory = ageCategory
        self.selectedCategory = category
        
        self.delegate?.indicatorView.startAnimating()
        
        if !self.recommendations.isEmpty {
            self.delegate?.indicatorView.stopAnimating()
            self.reloadRecommendations(recommendations)
        }else {
            Network.shared.getRecommendations { [weak self] statusCode, recommendations in
                self?.delegate?.indicatorView.stopAnimating()
                guard let recommendations else {
                    self?.pushAlert(statusCode)
                    return
                }
                
                self?.reloadRecommendations(recommendations)
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
    
    private func reloadRecommendations(_ recommendations: [Recommendation]) {
        DispatchQueue.main.async {
            var filteredRecs = recommendations
            if let selectedAgeCategory = self.selectedAgeCategory {
                filteredRecs = recommendations.filter({$0.ageCategory == selectedAgeCategory.id})
            }
            if let selectedCategory = self.selectedCategory {
                filteredRecs = filteredRecs.filter({$0.category == selectedCategory.id})
            }
            self.delegate?.reloadRecommendations(filteredRecs)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }
    }
}
