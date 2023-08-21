//
//  ChatViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class ChatViewController: BaseViewController {
    private var ageFilterCollectionView = AgeCategoriesView(.clear)
    private let recommendedGamesLabel = UILabel(text: "Tavsiya etilgan oyinlar".localizedString, font: .robotoFont(ofSize: 20, weight: .medium), color: .white)
    private var categoriesView = CategoriesView()
    private let gamesTableView = GamesTableView()
    private let presenter = ChatPresenter()
    
    private var selectedAgeCategory: AgeCategory?
    private var selectedCategory: Category?
    
    private var firstLaunch = true
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.delegate = self
        navBarTitleLabel.text = "Oyinlar".localizedString
        leftMenuButton.tag = 2
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLaunch {
            presenter.getAgeCategories()
            presenter.getCategories()
            presenter.getGames()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstLaunch = false
    }
    
    private func initialize() {
        ageFilterCollectionView.backgroundColor = .clear
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [ ageFilterCollectionView, categoriesView, recommendedGamesLabel, gamesTableView])
        gamesTableView.backgroundColor = .clear
        ageFilterCollectionView.selectAction = { [weak self] ageCategory in
            self?.selectedAgeCategory = ageCategory
            self?.presenter.getGames(ageCategory: ageCategory, category: self?.selectedCategory)
        }
        
        
        categoriesView.selectAction = { [weak self] category in
            self?.selectedCategory = category
            self?.presenter.getGames(ageCategory: self?.selectedAgeCategory, category: category)
        }
        
        gamesTableView.selectItem = { [weak self] game in
            let vc = GameDetailViewController(game: game)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ageFilterCollectionView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            ageFilterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ageFilterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ageFilterCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            categoriesView.topAnchor.constraint(equalTo: ageFilterCollectionView.bottomAnchor, constant: 16),
            categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            recommendedGamesLabel.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 16),
            recommendedGamesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recommendedGamesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            recommendedGamesLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            
            gamesTableView.topAnchor.constraint(equalTo: recommendedGamesLabel.bottomAnchor, constant: 16),
            gamesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gamesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gamesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
        ])
    }

}

extension ChatViewController: ChatPresenterProtocol {
    func reloadAgeCategories(_ ageCategories: [AgeCategory]) {
        self.ageFilterCollectionView.updateItems(items: ageCategories)
    }
    
    func reloadCategories(_ categories: [Category]) {
        self.categoriesView.updateItems(categories, type: .game)
        self.categoriesView.heightAnchor.constraint(equalToConstant: categoriesView.getHeight()).isActive = true
    }
    
    func reloadGames(_ games: [Game]) {
        noDataView.isHidden = games.isEmpty ? false : true
        self.gamesTableView.updateItems(games)
    }
}
