//
//  GamesTableView.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import UIKit

class GamesTableView: UIView {
    private let tableView: UITableView = UITableView()
    private var items = [Game]()
    var isWaiting = false
    var pageNumber = 1
    var totalPages = 1
    
    var selectItem: ((Game) -> ())?
    var loadMore: ((Int) -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: self, view: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = (UIScreen.main.bounds.width - 32) * 0.82
        tableView.register(GameViewCell.self, forCellReuseIdentifier: "GameCell")
        tableView.separatorStyle = .none
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func updateItems(_ games: [Game]) {
        items = games
        tableView.reloadData()
    }
    
    func appendItems(_ games: [Game]) {
        items += games
        tableView.reloadData()
        isWaiting = false
    }
}

extension GamesTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameViewCell
        cell.updateModel(model: items[indexPath.row])
        cell.saveAction = { [weak self] bool in
            guard let _ = self else { return }
            print(bool)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem?(items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 2 && !isWaiting && totalPages != pageNumber {
            isWaiting = true
            pageNumber += 1
            pageNumber = totalPages > pageNumber ? pageNumber : totalPages
            loadMore?(pageNumber)
        }
    }
}
