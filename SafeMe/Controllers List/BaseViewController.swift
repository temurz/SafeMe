//
//  MainViewController.swift
//  SafeMe
//
//  Created by Temur on 18/07/2023.
//

import UIKit
import SideMenu
class BaseViewController: GradientViewController {
    let leftMenuButton = UIButton(color: .white, backgroundColor: .clear, image: UIImage(named: "leftMenuIcon"))
    let navBarTitleLabel = UILabel()
    let searchButton = UIButton(color: .white, backgroundColor: .clear, image: UIImage(systemName: "magnifyingglass"))
    let sosButton = UIButton(color: .white, backgroundColor: .clear, image: UIImage(named: "sosIcon"))
    let notificationsButton = UIButton(backgroundColor: .clear, image: UIImage(systemName: "bell.fill"))
    let profileButton = UIButton(backgroundColor: .clear, image: UIImage(named: "person"))
    let customNavBar = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navController = self.navigationController as! SideMenuNavigationController
        navController.leftSide = true
        navController.navigationBar.backgroundColor = .clear
        
        setNavBarContainer()
        
        navController.navigationBar.tintColor = .white
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        leftMenuButton.addTarget(self, action: #selector(leftSideMenuAction(_:)), for: .touchUpInside)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftMenuButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    private func setNavBarContainer() {
        
        let stackView = UIStackView()
        stackView.frame = .init(x: 0, y: 0, width: 200, height: 50)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(sosButton)
        stackView.addArrangedSubview(profileButton)
        
        sosButton.addTarget(self, action: #selector(sosButtonAction), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        profileButton.tintColor = .white
        profileButton.contentMode = .scaleAspectFill
        
        navBarTitleLabel.textAlignment = .left
        navBarTitleLabel.font = .robotoFont(ofSize: 14)
        navBarTitleLabel.numberOfLines = 0
        
        customNavBar.addArrangedSubview(leftMenuButton)
        customNavBar.addArrangedSubview(navBarTitleLabel)

        customNavBar.addArrangedSubview(stackView)
        customNavBar.alignment = .fill
        customNavBar.distribution = .fill
        customNavBar.spacing = 8
        customNavBar.alignment = .center

        self.view.addSubview(customNavBar)
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        navBarTitleLabel.textColor = .custom.white
        navBarTitleLabel.font = .boldSystemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            customNavBar.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
//        NSLayoutConstraint.activate([
//
//            profileButton.topAnchor.constraint(equalTo: testView.topAnchor),
//            profileButton.heightAnchor.constraint(equalToConstant: 24),
//            profileButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor, multiplier: 1),
//            profileButton.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -16),
//
//            sosButton.topAnchor.constraint(equalTo: testView.topAnchor),
//            sosButton.heightAnchor.constraint(equalToConstant: 24),
//            sosButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor, multiplier: 1),
//            sosButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -16),
//
//            notificationsButton.topAnchor.constraint(equalTo: testView.topAnchor),
//            notificationsButton.heightAnchor.constraint(equalToConstant: 24),
//            notificationsButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor, multiplier: 1),
//            notificationsButton.trailingAnchor.constraint(equalTo: sosButton.leadingAnchor, constant: -16),
//
//            searchButton.topAnchor.constraint(equalTo: testView.topAnchor),
//            searchButton.heightAnchor.constraint(equalToConstant: 24),
//            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor, multiplier: 1),
//            searchButton.trailingAnchor.constraint(equalTo: notificationsButton.leadingAnchor, constant: -16),
//
//
//        ])
    }
    
    
    
    @objc public func leftSideMenuAction(_ sender: UIButton) {
        let vc = SideMenuViewController(currentRow: sender.tag)
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        var menuSettings = SideMenuSettings()
        menuSettings.presentationStyle = .menuSlideIn
        menuSettings.menuWidth = self.view.frame.width * 0.84
        menu.settings = menuSettings
        menu.pushStyle = .replace
        menu.allowPushOfSameClassTwice = false
        vc.selectedRowAction = { id in
            switch id {
            case 0:
                menu.pushViewController(SuggestionsViewController(), animated: true)
            case 1:
                menu.pushViewController(NewsViewController(), animated: true)
            case 2:
                menu.pushViewController(ChatViewController(), animated: true)
            case 3:
                break
//                menu.pushViewController(ConsultantViewController(), animated: true)
            case 4:
                menu.pushViewController(PollViewController(), animated: true)
            case 5:
                menu.pushViewController(InspectorsViewController(), animated: true)
            case 6:
                menu.pushViewController(ApplicationsViewController(), animated: true)
            case 7:
                menu.pushViewController(AboutViewController(), animated: true)
            case 8:
                AuthApp.shared.removeTokens()
                AuthApp.shared.appEnterCode = nil
                let vc = LanguageViewController()
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                let navController = UINavigationController(rootViewController: vc)
                keyWindow?.rootViewController = navController
            default:
                break
            }
        }
        present(menu, animated: true, completion: nil)
    }
    
    @objc private func sosButtonAction() {
        let vc = SosViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func profileButtonAction() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
