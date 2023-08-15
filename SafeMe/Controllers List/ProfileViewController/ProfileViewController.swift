//
//  ProfileViewController.swift
//  SafeMe
//
//  Created by Даулетбай Комекбаев on 28/07/23.
//

import UIKit

class ProfileViewController: GradientViewController {
    
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    private let backgroundView = UIView(.white)
    
    private let profilePhoto = UIImageView()
    private let fullnameLabel = UILabel()
    
    private let childLabel = UILabel()
    private let parentLabel = UILabel()
    
    private let dateLabel = UILabel()
    private let birthLabel = UILabel()
    private let lineBorder = UIView()
    
    private let eduLabel = UILabel()
    private let eduNameLabel = UILabel()
    
    private let cityLabel = UILabel()
    private let cityNameLabel = UILabel()
    
    private let countryLabel = UILabel()
    private let countryNameLabel = UILabel()
    
    private let streetLabel = UILabel()
    private let streetNameLabel = UILabel()
    
    var model: User?
    let presenter = ProfileViewPresenter()
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getUser()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [backgroundView, firstButton, secondButton, profilePhoto, fullnameLabel, parentLabel, birthLabel, childLabel, dateLabel, lineBorder, eduLabel, eduNameLabel, cityLabel, cityNameLabel, countryLabel, countryNameLabel, streetLabel, streetNameLabel])
        
        profilePhoto.image = UIImage(named: "profileSample")
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.cornerRadius = 4
        
        fullnameLabel.text = "Mardon Shonazarov"
        fullnameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        fullnameLabel.textColor = .black
        fullnameLabel.numberOfLines = 0
        
        childLabel.text = "Bolaning:"
        childLabel.textColor = .systemGray
        childLabel.font = .systemFont(ofSize: 14)
        childLabel.isHidden = true
        
        parentLabel.text = ""
        parentLabel.textColor = .black
        parentLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        birthLabel.text = "Tug’ilgan sanasi:"
        birthLabel.textColor = .systemGray
        birthLabel.font = .systemFont(ofSize: 14)
        birthLabel.numberOfLines = 0

        dateLabel.text = "12.02.1993"
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        lineBorder.backgroundColor = .custom.lightGray
        
        eduLabel.text = "Ta'lim:"
        eduLabel.textColor = .systemGray
        eduLabel.font = .systemFont(ofSize: 14)

        eduNameLabel.text = "Toshkent Arxitektura Qurilish Instituti"
        eduNameLabel.textColor = .black
        eduNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        cityLabel.text = "Viloyat:"
        cityLabel.textColor = .systemGray
        cityLabel.font = .systemFont(ofSize: 14)
        
        cityNameLabel.text = "Toshkent shaxar"
        cityNameLabel.textColor = .black
        cityNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        countryLabel.text = "Tuman:"
        countryLabel.textColor = .systemGray
        countryLabel.font = .systemFont(ofSize: 14)
        
        countryNameLabel.text = "Chilonzor"
        countryNameLabel.textColor = .black
        countryNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        streetLabel.text = "Mahalla:"
        streetLabel.textColor = .systemGray
        streetLabel.font = .systemFont(ofSize: 14)
        
        streetNameLabel.text = "Obod MFY"
        streetNameLabel.textColor = .black
        streetNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        firstButton.layer.borderWidth = 1
        firstButton.backgroundColor = .clear
        firstButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#1ACBAE").cgColor
        firstButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        firstButton.setTitle("Profilni tahrirlash", for: .normal)
        firstButton.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)
        firstButton.layer.cornerRadius = 8
        firstButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#1ACBAE"), for: .normal)
        
        secondButton.layer.borderWidth = 1
        secondButton.backgroundColor = .clear
        secondButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#1ACBAE").cgColor
        secondButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        secondButton.setTitle("Parolni o'zgartiring", for: .normal)
        secondButton.layer.cornerRadius = 8
        secondButton.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
        secondButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#1ACBAE"), for: .normal)
        
        backgroundView.layer.cornerRadius = 12
        
        
    }
    
    private func setupConstraints() {
        let textWidth = self.view.frame.width * 0.15
        NSLayoutConstraint.activate([
            
            profilePhoto.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            profilePhoto.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            profilePhoto.widthAnchor.constraint(equalToConstant: 80),
            profilePhoto.heightAnchor.constraint(equalToConstant: 96),
            
            fullnameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 17),
            fullnameLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            fullnameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            childLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 7),
            childLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            childLabel.widthAnchor.constraint(equalToConstant: 60),
            
            
            parentLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 7),
            parentLabel.leadingAnchor.constraint(equalTo: childLabel.trailingAnchor, constant: 8),
            parentLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            birthLabel.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 7),
            birthLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            birthLabel.widthAnchor.constraint(equalToConstant: textWidth),
            
            
            dateLabel.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: birthLabel.trailingAnchor,constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            lineBorder.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 16),
            lineBorder.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            lineBorder.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            lineBorder.heightAnchor.constraint(equalToConstant: 2),
            
            eduLabel.topAnchor.constraint(equalTo: lineBorder.bottomAnchor, constant: 20),
            eduLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            eduLabel.widthAnchor.constraint(equalToConstant: textWidth),
            
            eduNameLabel.topAnchor.constraint(equalTo: lineBorder.bottomAnchor, constant: 16),
            eduNameLabel.leadingAnchor.constraint(equalTo: eduLabel.trailingAnchor, constant: 8),
            eduNameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            cityLabel.topAnchor.constraint(equalTo: eduLabel.bottomAnchor, constant: 13),
            cityLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            cityLabel.widthAnchor.constraint(equalToConstant: textWidth),
            
            cityNameLabel.topAnchor.constraint(equalTo: eduLabel.bottomAnchor, constant: 10),
            cityNameLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 8),
            cityNameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            countryLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            countryLabel.widthAnchor.constraint(equalToConstant: textWidth),
            
            countryNameLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            countryNameLabel.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor, constant: 8),
            countryNameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            streetLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            streetLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            streetLabel.widthAnchor.constraint(equalToConstant: textWidth),
            
            streetNameLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 10),
            streetNameLabel.leadingAnchor.constraint(equalTo: streetLabel.trailingAnchor, constant: 8),
            streetNameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            firstButton.bottomAnchor.constraint(equalTo: secondButton.topAnchor, constant: -16),
            firstButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            firstButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            firstButton.heightAnchor.constraint(equalTo: firstButton.widthAnchor, multiplier: 0.12),
            
            secondButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16),
            secondButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            secondButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            secondButton.heightAnchor.constraint(equalTo: secondButton.widthAnchor, multiplier: 0.12),
            
            
        ])
    }
    
    @objc private func firstButtonAction() {
        print("Profilni tahrirlash!")
    }
    
    @objc private func secondButtonAction() {
        print("Parolni o'zgartiring!")
    }
}


extension ProfileViewController: ProfileViewPresenterProtocol {
    func reloadUser(_ user: User) {
        self.model = user
        profilePhoto.sd_setImage(with: URL(string: user.photo))
        fullnameLabel.text = user.first_name + " " + user.last_name
        dateLabel.text = user.birth_day
        cityNameLabel.text = user.region
        countryNameLabel.text = user.district
        streetNameLabel.text = user.mahalla
    }
}
