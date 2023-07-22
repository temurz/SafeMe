//
//  LoginViewController.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

class LoginViewController: GradientViewController {
    private let presenter: LoginPresenter
    private let bgView = UIView()
    private let titleLabel = UILabel(text: "Kirish".localizedString, font: .systemFont(ofSize: 20), color: .custom.black)
    private let subtitleLabel = UILabel(text: "Kirish uchun telefon raqamingizni va parolingizni kiriting".localizedString, font: .systemFont(ofSize: 14),color: .custom.gray)
    private let phoneTextField = UICustomTextField(title: "Username".localizedString, star: false, text: "+998", placeholder: "", height: 50)
    private let passwordTextField = UICustomTextField(title: "Password".localizedString, star: false, text: nil, placeholder: "Password".localizedString, height: 50, type: .pass)
    private let nextButton = UIButton(backgroundColor: UIColor.buttonBackgroundColor, textColor: .custom.white, text: "Davom ettirish".localizedString)
    
    override init() {
        self.presenter = LoginPresenter()
        super.init()
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
    
    func initialize() {
        presenter.delegate = self
        bgView.layer.cornerRadius = 12
        bgView.backgroundColor = .white
        bgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bgView)
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, subtitleLabel, phoneTextField, passwordTextField, nextButton])
        
        subtitleLabel.numberOfLines = 0
        
        passwordTextField.isSecureTextField = true
        
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
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
            
            passwordTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    @objc private func nextAction() {
        presenter.loginAction(username: phoneTextField.text, pass: passwordTextField.text)
    }
}


extension LoginViewController: LoginPresenterProtocol {
    func successAutorization() {
        let vc = ApplicationCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func login() -> (username: String, password: String) {
        return (username: phoneTextField.text, password: passwordTextField.text)
    }
}
