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
    
    private let cityLabel = UILabel()
    private let cityNameLabel = UILabel()
    
    private let countryLabel = UILabel()
    private let countryNameLabel = UILabel()
    
    private let streetLabel = UILabel()
    private let streetNameLabel = UILabel()
    
    private let deleteAccountButton = UIButton(backgroundColor: .clear, textColor: UIColor.hexStringToUIColor(hex: "C63D2F"), text: "Delete account".localizedString, radius: 12)
    
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
        indicatorView.stopAnimating()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [backgroundView, firstButton, secondButton, profilePhoto, fullnameLabel, parentLabel, birthLabel, childLabel, dateLabel, lineBorder, cityLabel, cityNameLabel, countryLabel, countryNameLabel, streetLabel, streetNameLabel, deleteAccountButton])
        
        profilePhoto.image = UIImage(systemName: "person.crop.circle")
        profilePhoto.tintColor = .gray
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.cornerRadius = 4
        
        fullnameLabel.text = ""
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
        
        birthLabel.text = "Birthday:".localizedString
        birthLabel.textColor = .systemGray
        birthLabel.font = .systemFont(ofSize: 14)
        birthLabel.numberOfLines = 0

        dateLabel.text = ""
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        lineBorder.backgroundColor = .custom.lightGray
        
        cityLabel.text = "Viloyat:".localizedString
        cityLabel.textColor = .systemGray
        cityLabel.font = .systemFont(ofSize: 14)
        
        cityNameLabel.text = ""
        cityNameLabel.textColor = .black
        cityNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        countryLabel.text = "Tuman:".localizedString
        countryLabel.textColor = .systemGray
        countryLabel.font = .systemFont(ofSize: 14)
        
        countryNameLabel.text = ""
        countryNameLabel.textColor = .black
        countryNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        streetLabel.text = "Mahalla:".localizedString
        streetLabel.textColor = .systemGray
        streetLabel.font = .systemFont(ofSize: 14)
        
        streetNameLabel.text = ""
        streetNameLabel.textColor = .black
        streetNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        firstButton.layer.borderWidth = 1
        firstButton.backgroundColor = .clear
        firstButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#1ACBAE").cgColor
        firstButton.titleLabel?.font = .robotoFont(ofSize: 14, weight: .medium)
        firstButton.setTitle("Edit profile".localizedString, for: .normal)
        firstButton.addTarget(self, action: #selector(updateProfileButtonAction), for: .touchUpInside)
        firstButton.layer.cornerRadius = 8
        firstButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#1ACBAE"), for: .normal)
        
        secondButton.layer.borderWidth = 1
        secondButton.backgroundColor = .clear
        secondButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#1ACBAE").cgColor
        secondButton.titleLabel?.font = .robotoFont(ofSize: 14, weight: .medium)
        secondButton.setTitle("Change password".localizedString, for: .normal)
        secondButton.layer.cornerRadius = 8
        secondButton.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
        secondButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#1ACBAE"), for: .normal)
        
        deleteAccountButton.layer.borderWidth = 1
        deleteAccountButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "C63D2F").cgColor
        deleteAccountButton.titleLabel?.font = .robotoFont(ofSize: 14, weight: .medium)
        deleteAccountButton.layer.cornerRadius = 8
        deleteAccountButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
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
            
            birthLabel.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 6),
            birthLabel.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 16),
            birthLabel.widthAnchor.constraint(equalToConstant: textWidth + 10),
            
            
            dateLabel.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: birthLabel.trailingAnchor,constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            lineBorder.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 16),
            lineBorder.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            lineBorder.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            lineBorder.heightAnchor.constraint(equalToConstant: 2),
            
            cityLabel.topAnchor.constraint(equalTo: lineBorder.bottomAnchor, constant: 12),
            cityLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            cityLabel.widthAnchor.constraint(equalToConstant: textWidth),
            
            cityNameLabel.topAnchor.constraint(equalTo: lineBorder.bottomAnchor, constant: 12),
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
            
            secondButton.bottomAnchor.constraint(equalTo: deleteAccountButton.topAnchor, constant: -16),
            secondButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            secondButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            secondButton.heightAnchor.constraint(equalTo: secondButton.widthAnchor, multiplier: 0.12),
            
            deleteAccountButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16),
            deleteAccountButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            deleteAccountButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            deleteAccountButton.heightAnchor.constraint(equalTo: deleteAccountButton.widthAnchor, multiplier: 0.12),
        ])
    }
    
    @objc private func updateProfileButtonAction() {
        self.indicatorView.startAnimating()
        let vc = UpdateProfileViewController(user: model, withNavigation: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func secondButtonAction() {
        let vc = ChangePasswordViewController(phoneNumber: model?.phone ?? "", isBackToLogin: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func deleteButtonAction() {
        let alertController = UIAlertController(title: "Account deletion".localizedString, message: "Are sure that you want delete your account?".localizedString, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No".localizedString, style: .cancel)
        let yesAction = UIAlertAction(title: "Yes".localizedString, style: .default) { [weak self] _ in
            guard let self else { return }
            if let model = self.model {
                self.presenter.deleteUser(userId: model.id)
            }
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        present(alertController, animated: true)
    }
}


extension ProfileViewController: ProfileViewPresenterProtocol {
    func reloadUser(_ user: User) {
        self.model = user
        profilePhoto.sd_setImage(with: URL(string: user.photo ?? ""))
        fullnameLabel.text = user.first_name + " " + user.last_name
        dateLabel.text = user.birth_day
        cityNameLabel.text = user.region
        countryNameLabel.text = user.district
        streetNameLabel.text = user.mahalla
    }
    
    func successfullyDeleteUser() {
        let vc = LoginViewController()
        let navController = UINavigationController(rootViewController: vc)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController = navController
    }
}
