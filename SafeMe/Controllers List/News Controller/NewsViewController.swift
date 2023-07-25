//
//  NewsController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class NewsViewController: BaseViewController {
    private let tableView = UITableView()
    private var items: [NewsModel] = [
        NewsModel(image: "elon1", title: "Videopodkat", subtitle: "Бухоро вилояти ёшлари итирокидаКибержиноятлардан химояланиш буйича очик мулокот", hexTitle: "#Биз_хар_бир_оила_билан_биршамиз /n Хештеги остида! Видеоподкаст", date: Date(), views: nil, borderColor: "#63D586"),
        NewsModel(image: "elon2", title: "Videopodkat", subtitle: "Бухоро вилояти ёшлари итирокидаКибержиноятлардан химояланиш буйича очик мулокот", hexTitle: "#Биз_хар_бир_оила_билан_биршамиз /n Хештеги остида! Видеоподкаст", date: Date(), views: nil, borderColor: "#C7A9F5"),
        NewsModel(image: "elon3", title: "Videopodkat", subtitle: "Бухоро вилояти ёшлари итирокидаКибержиноятлардан химояланиш буйича очик мулокот", hexTitle: "#Биз_хар_бир_оила_билан_биршамиз /n Хештеги остида! Видеоподкаст", date: Date(), views: nil, borderColor: "#FFA607"),
    ]
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "E'lonlar"
        leftMenuButton.tag = 1
        setupConstraints()
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
}
