//
//  InspectorsViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class InspectorsViewController: BaseViewController {
    private let tableView = UITableView()
    private var presenter: InspectorsPresenter?
    private var inspectors = [Inspector]()
    
    override func loadView() {
        super.loadView()
        presenter = InspectorsPresenter()
        presenter?.delegate = self
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "Inspektorlar".localizedString
        leftMenuButton.tag = 5
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getInspectors(mahalla: 1)
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
        cell.updateModel(item: inspectors[indexPath.row])
        cell.call = { [weak self] number in
            guard let self else { return }
            self.presenter?.call(number)
        }
        
        cell.redirectAction = { [weak self] in
            guard let self else {return}
            self.presenter?.telegram()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inspectors.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
}

extension InspectorsViewController: InspectorsPresenterProtocol {
    func reloadData(inspectors: [Inspector]) {
        noDataView.isHidden = inspectors.isEmpty ? false : true
        self.inspectors = inspectors
        self.tableView.reloadData()
    }
}
