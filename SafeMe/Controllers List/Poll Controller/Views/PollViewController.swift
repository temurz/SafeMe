//
//  PollViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class PollViewController: BaseViewController {
    private var ageFilterCollectionView = AgeCategoriesView(.clear)
    private let tableView = UITableView(.clear)
    private let presenter = PollViewPresenter()
    
    var totalPages = 1
    var pageNumber = 1
    var isWaiting = false

    var items = [PollingModel]()
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "Poll".localizedString
        leftMenuButton.tag = 4
        presenter.delegate = self
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getAgeCategories()
        
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [ageFilterCollectionView, tableView])

        ageFilterCollectionView.selectAction = { [weak self] ageCategory in
            self?.presenter.getPolls(page: 1, ageCategory: ageCategory)
        }
        
        tableView.rowHeight = self.view.frame.width - 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PollingCell.self, forCellReuseIdentifier: "PollingCell")
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ageFilterCollectionView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            ageFilterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ageFilterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ageFilterCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: ageFilterCollectionView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            
        ])
    }
}

extension PollViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PollingCell") as! PollingCell
        cell.updateModel(items[indexPath.row])
        cell.didSelectStart = { [weak self] in
            guard let self else { return }
            let vc = PollDetailViewController(model: self.items[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == items.count - 2 && !isWaiting && totalPages != pageNumber {
//            isWaiting = true
//            pageNumber += 1
//            pageNumber = totalPages > pageNumber ? pageNumber : totalPages
//            loadMore(pageNumber)
//        }
//    }
    
    func loadMore(_ pageNumber: Int) {
        presenter.getPolls(page: pageNumber)
    }
}

extension PollViewController: PollViewPresenterProtocol {
    func updatePolls(_ polls: [PollingModel], totalPages: Int) {
        noDataView.isHidden = polls.isEmpty ? false : true
//        self.totalPages = totalPages
//        if isWaiting {
//            self.items += polls
//            isWaiting = false
//        }else {
            self.items = polls
//        }
        self.tableView.reloadData()
    }
    
    func reloadAgeCategories(_ ageCategories: [AgeCategory]) {
        ageFilterCollectionView.updateItems(items: ageCategories)
        if !ageCategories.isEmpty {
            presenter.getPolls(page: 1, size: 10, ageCategory: ageCategories[0])
        }
    }
}
