//
//  AboutViewController.swift
//  SafeMe
//
//  Created by Temur on 18/07/2023.
//

import UIKit
import SideMenu

class AboutViewController: BaseViewController {
    
    private let cyber102ImageView = UIImageView()
    private let unicefImageView = UIImageView()
    private let fourthTitleLabel = UILabel()
    private let thirdTitleLabel = UILabel()
    private let secondTitleLabel = UILabel()
    private let firstTitleLabel = UILabel()
    private let backgroundView = UIView(.white)
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuButton.tag = 7
        navBarTitleLabel.text = "Biz haqqimizda".localizedString
        setupConstraints()
    }
    
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [backgroundView, cyber102ImageView, unicefImageView, secondTitleLabel, firstTitleLabel, thirdTitleLabel, fourthTitleLabel, ])
        
        backgroundView.layer.cornerRadius = 12
        
        cyber102ImageView.image = UIImage(named: "cyber102Logo")
        cyber102ImageView.contentMode = .scaleAspectFit
        cyber102ImageView.clipsToBounds = true
        self.view.addSubview(cyber102ImageView)
        
        unicefImageView.image = UIImage(named: "unicefLogo")
        unicefImageView.contentMode = .scaleAspectFit
        unicefImageView.clipsToBounds = true
        self.view.addSubview(unicefImageView)
        
        firstTitleLabel.text = "Biz haqqimizda".localizedString
        firstTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        firstTitleLabel.textAlignment = .center
        self.view.addSubview(firstTitleLabel)
        
        secondTitleLabel.text = "The purpose of this project is to protect\n children from aggressive\n dangers in the world of the Internet in our country, to increase their awareness and\n culture of using the Internet, as well as to protect children from dangers such as cyberbullying, which is current\n at the moment.".localizedString
        secondTitleLabel.font = .systemFont(ofSize: 14)
        secondTitleLabel.textColor = .systemGray
        secondTitleLabel.numberOfLines = 0
        secondTitleLabel.textAlignment = .center
        self.view.addSubview(secondTitleLabel)
        
        thirdTitleLabel.text = "Mazkur proekt Unicef xalqaro bolalar\n jamg’armasi va IIV Kiberxavfsizlik markazi\n tomonidan ishlab chiqildi.".localizedString
        thirdTitleLabel.textAlignment = .center
        thirdTitleLabel.font = .systemFont(ofSize: 12)
        thirdTitleLabel.numberOfLines = 0
        self.view.addSubview(thirdTitleLabel)
        
        fourthTitleLabel.text = "©2022 yil, barcha huquqlar himoyalangan".localizedString
        fourthTitleLabel.textAlignment = .center
        fourthTitleLabel.font = .systemFont(ofSize: 12)
        fourthTitleLabel.numberOfLines = 0
        self.view.addSubview(fourthTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            
            firstTitleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 28),
            firstTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondTitleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            secondTitleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16), 
            secondTitleLabel.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: 19),
            
            unicefImageView.widthAnchor.constraint(equalToConstant: 210),
            unicefImageView.heightAnchor.constraint(equalToConstant: 60),
            unicefImageView.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 57),
            unicefImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cyber102ImageView.widthAnchor.constraint(equalToConstant: 210),
            cyber102ImageView.heightAnchor.constraint(equalToConstant: 60),
            cyber102ImageView.topAnchor.constraint(equalTo: unicefImageView.bottomAnchor, constant: 36),
            cyber102ImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fourthTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthTitleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,constant: -40),
            
            thirdTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            thirdTitleLabel.topAnchor.constraint(equalTo: cyber102ImageView.bottomAnchor, constant: 80),
            thirdTitleLabel.bottomAnchor.constraint(equalTo: fourthTitleLabel.topAnchor, constant: -36),
            
            
            
        ])
    }
}

