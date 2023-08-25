//
//  ChatViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class ChatViewController: BaseViewController {
    private var ageFilterCollectionView = AgeCategoriesView(.clear)
    private let recommendedGamesLabel = UILabel(text: "Recommended Games".localizedString, font: .robotoFont(ofSize: 20, weight: .medium), color: .white)
    private let bookmarkedButton = UIImageView(image: UIImage(named: "star"))
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
        navBarTitleLabel.text = "Games".localizedString
        leftMenuButton.tag = 2
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLaunch {
            presenter.getAgeCategories()
            presenter.getCategories()
            presenter.getGames(page: 1, size: 17)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstLaunch = false
    }
    
    private func initialize() {
        ageFilterCollectionView.backgroundColor = .clear
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [ ageFilterCollectionView, categoriesView, recommendedGamesLabel, bookmarkedButton, gamesTableView])
        gamesTableView.backgroundColor = .clear
        
        gamesTableView.loadMore = { [weak self] pageNumber in
            guard let self else { return }
            self.presenter.getGames(page: pageNumber)
        }
        bookmarkedButton.contentMode = .scaleAspectFill
        ageFilterCollectionView.selectAction = { [weak self] ageCategory in
            self?.selectedAgeCategory = ageCategory
            self?.gamesTableView.canLoadMore = false
            self?.presenter.getGames(ageCategory: ageCategory, category: self?.selectedCategory, page: 1, size: 10)
        }
        
        
        categoriesView.selectAction = { [weak self] category in
            self?.selectedCategory = category
            self?.gamesTableView.canLoadMore = false
            self?.presenter.getGames(ageCategory: self?.selectedAgeCategory, category: category, page: 1, size: 10)
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
            recommendedGamesLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 24),
            
            bookmarkedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            bookmarkedButton.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 16),
            bookmarkedButton.heightAnchor.constraint(equalToConstant: 24),
            bookmarkedButton.widthAnchor.constraint(equalToConstant: 24),
            
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
    
    func reloadGames(_ games: [Game], totalPages: Int) {
        noDataView.isHidden = games.isEmpty ? false : true
        gamesTableView.totalPages = totalPages
        if gamesTableView.isWaiting {
            self.gamesTableView.appendItems(games)
        }else {
            self.gamesTableView.updateItems(games)
        }
        
    }
}
