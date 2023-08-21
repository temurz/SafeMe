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
        presenter.getPolls()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [ageFilterCollectionView, tableView])

        ageFilterCollectionView.selectAction = { [weak self] ageCategory in
            self?.presenter.getPolls(ageCategory: ageCategory)
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
}

extension PollViewController: PollViewPresenterProtocol {
    func updatePolls(_ polls: [PollingModel]) {
        noDataView.isHidden = polls.isEmpty ? false : true
        items = polls
        self.tableView.reloadData()
    }
    
    func reloadAgeCategories(_ ageCategories: [AgeCategory]) {
        ageFilterCollectionView.updateItems(items: ageCategories)
    }
}
