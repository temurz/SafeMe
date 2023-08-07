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
    
    override func loadView() {
        super.loadView()
        presenter.delegate = self
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "E'lonlar"
        leftMenuButton.tag = 1
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getNews()
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
        cell.updateModel(model: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailViewController(news: items[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController: NewsPresenterProtocol {
    func reloadData(news: [News]) {
        self.items = news
        self.tableView.reloadData()
    }
    
}