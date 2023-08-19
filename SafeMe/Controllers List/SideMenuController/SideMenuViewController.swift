//
//  TestViewController.swift
//  SafeMe
//
//  Created by Temur on 17/07/2023.
//

import UIKit

class SideMenuViewController: UIViewController {
    private let headerView = UIView()
    private let logoImageView = UIImageView()
    private let tableView = UITableView()
    private let items = [
        MenuModel(id: 0, image: "suggestions", title: "Tavsiyalar".localizedString),
        MenuModel(id: 1, image: "news", title: "E'lonlar".localizedString),
        MenuModel(id: 2, image: "chat", title: "Oyinlar".localizedString),
//        MenuModel(id: 3, image: "consultant", title: "Konsultant"),
        MenuModel(id: 4, image: "poll", title: "So'rovnoma".localizedString),
        MenuModel(id: 5, image: "inspector", title: "Profilaktika inspektori".localizedString),
        MenuModel(id: 6, image: "application", title: "Murojaatlar".localizedString),
        MenuModel(id: 7, image: "about", title: "Biz haqqimizda".localizedString),
        MenuModel(id: 8, image: "exit", title: "Chiqish".localizedString),
    ]
    
    var selectedRowAction: ((Int) -> ())?
    var currentRow: Int
    
    init(currentRow: Int) {
        self.currentRow = currentRow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupConstraints()
    }
    
    private func initialize() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        headerView.backgroundColor = .custom.mainBackgroundColor
        
        logoImageView.image = UIImage(named: "safemelogo")
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [headerView, logoImageView])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 104),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 85),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.updateModel(model: items[indexPath.row], currentRow: currentRow)
        cell.selectedBackgroundView = UIView(.custom.cellBackgroundColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuCell
        cell.changeSelectedStyle(selected: true)
        self.selectedRowAction?(items[indexPath.row].id)
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuCell
        cell.changeSelectedStyle(selected: false)
    }
}
