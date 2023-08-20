//
//  LanguageViewController.swift
//  SafeMe
//
//  Created by Temur on 19/08/2023.
//

import UIKit
class LanguageViewController: GradientViewController {
    private let bgView = UIView(.white,radius: 12)
    private let welcomeLabel = UILabel(text: "Hello!\nPlease select a language!".localizedString, font: .robotoFont(ofSize: 20, weight: .bold))
    private let tableView = UITableView(.clear)
    private var items = [("english-flag", "English", "en"),
                         ("russian-flag", "Русский", "ru"),
                         ("uzbekistan-flag", "O'zbekcha-lotin", "uz"),
                         ("uzbekistan-flag", "Ўзбекча-кирилл", "uz-Cyrl")
    ]
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func initialize() {
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [welcomeLabel, tableView])
        welcomeLabel.numberOfLines = 2
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 48
        tableView.register(LanguageViewCell.self, forCellReuseIdentifier: "LanguageCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalToConstant: self.view.frame.width * 1.2),
            
            welcomeLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -12),
            
        ])
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as? LanguageViewCell {
            cell.updateModel(image: items[indexPath.row].0, language: items[indexPath.row].1)
            return cell
        }
        return .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let language = items[indexPath.row].2
        AuthApp.shared.language = language
        let vc = LoginViewController()
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        let navController = UINavigationController(rootViewController: vc)
        keyWindow?.rootViewController = navController
    }
}
