//
//  RegistrationViewController.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

class RegistrationViewController: GradientViewController {
    private let bgView = UIView()
    private let titleLabel = UILabel(text: "Ro'yxatdan o'tish", font: .systemFont(ofSize: 20), color: .custom.black)
    private let subtitleLabel = UILabel(text: "Ro'yxatdan o'tish uchun telefon raqamingizni kiriting", font: .systemFont(ofSize: 14),color: .custom.gray)
    private let phoneTextField = UICustomTextField(title: "Номер телефона", star: false, text: "+998", placeholder: "", height: 50)
    private let nextButton = UIButton(backgroundColor: UIColor.buttonBackgroundColor, textColor: .custom.white, text: "Davom ettirish")
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    func initialize() {
        bgView.layer.cornerRadius = 12
        bgView.backgroundColor = .white
        bgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bgView)
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, subtitleLabel, phoneTextField, nextButton])
        
        subtitleLabel.numberOfLines = 0
        
        nextButton.layer.cornerRadius = 8
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            phoneTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            phoneTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}
