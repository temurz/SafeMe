//
//  LoginViewController.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

enum RegistrationType {
    case login
    case register
    case forgetPassword
    case checkCode
}

class LoginViewController: GradientViewController {
    private let presenter: LoginPresenter
    private let bgView = UIView()
    private let titleLabel = UILabel(text: "Sign in".localizedString,
                                     font: .robotoFont(ofSize: 20, weight: .medium),
                                     color: .custom.black)
    private let subtitleLabel = UILabel(text: "Enter your phone number and password to login".localizedString,
                                        font: .robotoFont(ofSize: 15, weight: .regular),
                                        color: .custom.gray)
    
    private let phoneTextField = UICustomTextField(title: "Username".localizedString,
                                                   star: true,
                                                   text: "+998900109258",
                                                   placeholder: "",
                                                   height: 60)
    private let passwordTextField = UICustomTextField(title: "Password".localizedString,
                                                      star: true,
                                                      text: "Police2021@Admin",
                                                      placeholder: "Password".localizedString,
                                                      height: 60,
                                                      type: .pass)
    private let repeatPasswordTextField = UICustomTextField(title: "Repeat password".localizedString,
                                                            star: true,
                                                            text: nil,
                                                            placeholder: "password",
                                                            height: 60,
                                                            type: .pass)
    
    private let nextButton = UIButton(backgroundColor: UIColor.custom.buttonBackgroundColor,
                                      textColor: .custom.white,
                                      text: "Next".localizedString)
    private let forgotPasswordButton = UIButton(backgroundColor: .clear,
                                                textColor: .blue,
                                                text: "Forgot your password?".localizedString)
    private let registrationButton = UIButton(backgroundColor: .clear,
                                              textColor: .blue,
                                              text: "Sign up".localizedString)
    
    private lazy var codeView = CodeView()
    private var backButton = UIButton(backgroundColor: .clear, textColor: .custom.blue, text: "Back".localizedString)
    
    private var isLogin = RegistrationType.login
    
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
//        showCodeConfirmation(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        goToUpdateProfile()
    }
    
    func initialize() {
        presenter.delegate = self
        bgView.layer.cornerRadius = 12
        bgView.backgroundColor = .white
        bgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bgView)
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, subtitleLabel, phoneTextField, passwordTextField, repeatPasswordTextField, nextButton, codeView, forgotPasswordButton, registrationButton, backButton])
        
        codeView.isHidden = true
        codeView.requestSMS = { [weak self] in
            guard let self else { return }
            self.presenter.register(username: self.phoneTextField.text, pass: self.passwordTextField.text, repeatPassword: self.repeatPasswordTextField.text)
        }
        
        subtitleLabel.numberOfLines = 0
        
        passwordTextField.isSecureTextField = true
        repeatPasswordTextField.isSecureTextField = true
        repeatPasswordTextField.isHidden = true
        
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        forgotPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        forgotPasswordButton.contentHorizontalAlignment = .left
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        
        registrationButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        registrationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        registrationButton.contentHorizontalAlignment = .right
        registrationButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        backButton.isHidden = true
        backButton.contentHorizontalAlignment = .right
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.61),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            phoneTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            phoneTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            passwordTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 38),
            
            forgotPasswordButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -8),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: bgView.centerXAnchor, constant: -4),
            
            registrationButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            registrationButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -8),
            registrationButton.leadingAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 4),
            
            codeView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            codeView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            codeView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            codeView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
            
            backButton.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc private func nextAction() {
        switch isLogin {
        case .login:
            presenter.loginAction(username: phoneTextField.text, pass: passwordTextField.text)
        case .register:
            presenter.register(username: phoneTextField.text, pass: passwordTextField.text, repeatPassword: repeatPasswordTextField.text)
        case .forgetPassword:
            break
        case .checkCode:
            presenter.checkVerificationCode(code: codeView.getCodeText())
        }
        
    }
    
    @objc private func registerAction() {
        switch isLogin {
        case .login:
            isLogin = .register
            repeatPasswordTextField.isHidden = false
            passwordTextField.isHidden = false
            
            registrationButton.setTitle("Sign in".localizedString, for: .normal)
            
            titleLabel.text = "Sign up".localizedString
            subtitleLabel.text = "Enter your phone number to register".localizedString
            
        case .register:
            isLogin = .login
            repeatPasswordTextField.isHidden = true
            passwordTextField.isHidden = false
            
            registrationButton.setTitle("Sign up".localizedString, for: .normal)
            
            titleLabel.text = "Sign in".localizedString
            subtitleLabel.text = "Enter your phone number and password to login".localizedString
        case .forgetPassword:
            isLogin = .register
            repeatPasswordTextField.isHidden = false
            passwordTextField.isHidden = false

            registrationButton.setTitle("Sign in".localizedString, for: .normal)
            titleLabel.text = "Sign up".localizedString
            subtitleLabel.text = "Enter your phone number to register".localizedString
        case .checkCode:
            isLogin = .register
        }
    }
    
    @objc private func forgotPasswordAction() {
        switch isLogin {
        case .login:
            isLogin = .forgetPassword
            repeatPasswordTextField.isHidden = true
            passwordTextField.isHidden = true
            
            registrationButton.setTitle("Sign up".localizedString, for: .normal)
            titleLabel.text = "Password Reset".localizedString
            subtitleLabel.text = "Enter your phone number to reset your password".localizedString
        case .register:
            isLogin = .forgetPassword
            repeatPasswordTextField.isHidden = true
            passwordTextField.isHidden = true
            
            registrationButton.setTitle("Sign up".localizedString, for: .normal)
            titleLabel.text = "Password Reset".localizedString
            subtitleLabel.text = "Enter your phone number to reset your password".localizedString
        case .forgetPassword:
            break
        case .checkCode:
            break
        }
    }
    
    @objc private func backAction() {
        showCodeConfirmation(false)
    }
    
    private func showCodeConfirmation(_ bool: Bool) {
        if !bool {
            codeView.timer?.stopTimer()
        }else {
            timerVal = 120
            codeView.timer?.startTimer()
        }
        codeView.isHidden = !bool
        backButton.isHidden = !bool
        titleLabel.text = bool ? "Confirmation code".localizedString : "Sign up".localizedString
        subtitleLabel.text = bool ? "\(phoneTextField.text.makeStarsInsteadNumbers()) " + "enter the secret code sent to the number".localizedString : "Enter your phone number to register".localizedString
        isLogin = bool ? .checkCode : .register
        
        
        phoneTextField.isHidden = bool
        passwordTextField.isHidden = bool
        repeatPasswordTextField.isHidden = bool
        registrationButton.isHidden = bool
        forgotPasswordButton.isHidden = bool
        registrationButton.setTitle("Sign in".localizedString, for: .normal)
        
    }
    
    private func goToUpdateProfile() {
        let vc = UpdateProfileViewController(user: nil)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        let navController = UINavigationController(rootViewController: vc)
        keyWindow?.rootViewController = navController
    }
}


extension LoginViewController: LoginPresenterProtocol {
    func successAutorization() {
        let vc = ApplicationCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func successRegistration() {
        showCodeConfirmation(true)
    }
    
    func successCodeVerification() {
        goToUpdateProfile()
    }
}
