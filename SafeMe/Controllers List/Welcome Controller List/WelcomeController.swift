//
//  WelcomeController.swift
//  SafeMe
//
//  Created by Temur on 30/08/2023.
//

import UIKit

final class WelcomeController: GradientViewController {
    private let bgView = UIView(.white, radius: 12)
    private let nextButton = UIButton(backgroundColor: UIColor.custom.buttonBackgroundColor,
                                      textColor: .custom.white,
                                      text: "Next".localizedString, radius: 8)
    private let titleLabel = UILabel(text: "Welcome to SafeMe app".localizedString, font: .robotoFont(ofSize: 20, weight: .medium), color: .black)
    private let imageView = UIImageView(.clear)
    private let descriptionLabel = UILabel(text: "The purpose of this project is to protect\n children from aggressive\n dangers in the world of the Internet in our country, to increase their awareness and\n culture of using the Internet, as well as to protect children from dangers such as cyberbullying, which is current\n at the moment.".localizedString, font: .robotoFont(ofSize: 16), color: .custom.subtitleColor)
    
    var descriptionState = 0
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, descriptionLabel, nextButton])
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
//        imageView.image = UIImage(named: "recommendations_image")
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor,constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
//            descriptionLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
            descriptionLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
//            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
//            imageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 24),
//            imageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -24),
//            imageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor,constant: -16),
            
        ])
    }
    
    @objc private func nextAction() {
        descriptionState += 1
        switch descriptionState {
        case 1:
//            imageView.image = UIImage(named: "news_image")
            descriptionLabel.text = "Here you can find information about internet threats, how to be safe from them, recommendations for your children, and news in the world of internet".localizedString
        case 2:
            AuthApp.shared.isFirstEnter = 1
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
}
