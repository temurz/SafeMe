//
//  NewsController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class NewsViewController: BaseViewController {
    private let tableView = UITableView()
    private var items: [News] = []
    private let presenter: NewsPresenter = NewsPresenter()
    private var firstLaunch = true
    
    var totalPages = 1
    var pageNumber = 1
    var isWaiting = false
    
    override func loadView() {
        super.loadView()
        presenter.delegate = self
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "News".localizedString
        leftMenuButton.tag = 1
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLaunch {
            presenter.getNews(page: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstLaunch = false
    }
    
    private func initialize() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.rowHeight = (self.view.frame.width - 40)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        let color = UIColor.arrayOfBorderColors[indexPath.row % UIColor.arrayOfBorderColors.count]
        cell.updateModel(model: items[indexPath.row], borderColor: color)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailViewController(news: items[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 2 && !isWaiting && totalPages != pageNumber {
            isWaiting = true
            pageNumber += 1
            pageNumber = totalPages > pageNumber ? pageNumber : totalPages
            loadMore(pageNumber)
        }
    }
    
    func loadMore(_ pageNumber: Int) {
        presenter.getNews(page: pageNumber)
    }
}

extension NewsViewController: NewsPresenterProtocol {
    func reloadData(news: [News], totalPages: Int) {
        noDataView.isHidden = news.isEmpty ? false : true
        self.totalPages = totalPages
        if isWaiting {
            self.items += news
            isWaiting = false
        }else {
            self.items = news
        }
        self.tableView.reloadData()
    }
    
}
