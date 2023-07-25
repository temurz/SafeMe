//
//  InspectorsViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class InspectorsViewController: BaseViewController {
    
    private let tableView = UITableView()
    private var items: [InspectorModel] = [InspectorModel(image: "inspector2", fullname: "Закиров Нуриддин Абдухамидович", title: "Кушбеги” MFY profilaktka inspektori", phoneNumber: "97-430-10-44"),
                                              InspectorModel(image: "inspector1", fullname: "Закиров Нуриддин Абдухамидович", title: "Кушбеги” MFY profilaktka inspektori", phoneNumber: "97-430-10-44"),
                                              InspectorModel(image: "inspector2", fullname: "Закиров Нуриддин Абдухамидович", title: "Кушбеги” MFY profilaktka inspektori", phoneNumber: "97-430-10-44")]
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "Inspektorlar"
        leftMenuButton.tag = 5
        setupConstraints()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [tableView])
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InspectorCell.self, forCellReuseIdentifier: "InspektorCell")
        tableView.rowHeight = 242
        tableView.separatorStyle = .none

    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
                                    ])
    }
}

extension InspectorsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InspektorCell") as! InspectorCell
        cell.updateModel(item: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
}

