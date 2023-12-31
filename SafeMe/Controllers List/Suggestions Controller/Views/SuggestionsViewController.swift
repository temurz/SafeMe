//
//  ViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit
import SideMenu

class SuggestionsViewController: BaseViewController {
    let bgFilterView = UIView(.clear)
    private var ageFilterCollectionView = AgeCategoriesView(.clear)
    private var separatorLine = UIView(.custom.gray)
    private var categoriesView = CategoriesView()
    private var recommendationsView = RecommendationsView()
    private var presenter = SuggestionsPresenter()
    
    private var selectedAgeCategory: AgeCategory?
    private var selectedCategory: Category?
    private var firstLaunch = true
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        self.view.backgroundColor = .custom.mainBackgroundColor
        navBarTitleLabel.text = "Recommendations".localizedString
        leftMenuButton.tag = 0
        ageFilterCollectionView.backgroundColor = .clear
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLaunch {
            presenter.getAgeCategories()
            presenter.getCategories(type: "recomendation")
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
        firstLaunch = false
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgFilterView, view: ageFilterCollectionView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [bgFilterView, categoriesView, recommendationsView])
        
        ageFilterCollectionView.selectAction = { [weak self] ageCategory in
            self?.selectedAgeCategory = ageCategory
            self?.recommendationsView.pageNumber = 1
            self?.recommendationsView.canLoadMore = false
            self?.presenter.getRecommendations(ageCategory: ageCategory, category: self?.selectedCategory,page: 1)
        }
        
        categoriesView.selectAction = { [weak self] category in
            self?.selectedCategory = category
            self?.recommendationsView.pageNumber = 1
            self?.recommendationsView.canLoadMore = false
            self?.presenter.getRecommendations(ageCategory: self?.selectedAgeCategory,category: category, page: 1)
        }
        
        recommendationsView.selectAction = { [weak self] recommendation in
            let vc = RecommendationDetailViewController(recommendation: recommendation)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        recommendationsView.loadMore = { [weak self] pageNumber in
            guard let self else {return}
            self.presenter.getRecommendations(page: pageNumber)
        }
//        bgFilterView.layer.shadowColor = UIColor.black.cgColor
//        bgFilterView.layer.masksToBounds = true
//        bgFilterView.clipsToBounds = false
//        bgFilterView.layer.shadowOffset = CGSize(width: 0, height: 10)
//        bgFilterView.layer.shadowRadius = 7
//        bgFilterView.layer.shadowOpacity = 0.5

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgFilterView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            bgFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgFilterView.heightAnchor.constraint(equalToConstant: 50),
            
            categoriesView.topAnchor.constraint(equalTo: bgFilterView.bottomAnchor, constant: 16),
            categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            recommendationsView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 16),
            recommendationsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendationsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendationsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        ageFilterCollectionView.fullConstraint()
    }
}

extension SuggestionsViewController: SuggestionsPresenterProtocol {
    func reloadAgeCategories(_ ageCategories: [AgeCategory]) {
        if !ageCategories.isEmpty {
            selectedAgeCategory = ageCategories[0]
        }
        self.ageFilterCollectionView.updateItems(items: ageCategories)
        presenter.getRecommendations(ageCategory: self.selectedAgeCategory,page: 1)
    }
    
    func reloadCategories(_ categories: [Category]) {
        let filteredItems = categories.filter({$0.type == "recomendation"})
        self.categoriesView.updateItems(filteredItems, type: .recommendation)
        self.categoriesView.heightAnchor.constraint(equalToConstant: categoriesView.getHeight()).isActive = true
    }
    
    func reloadRecommendations(_ recommendations: [Recommendation], totalPages: Int) {
        noDataView.isHidden = recommendations.isEmpty ? false : true
        self.recommendationsView.totalPages = totalPages
//        if recommendationsView.isWaiting {
//            self.recommendationsView.appendItems(recommendations)
//        }else {
            self.recommendationsView.updateItems(recommendations)
//        }
    }
}

