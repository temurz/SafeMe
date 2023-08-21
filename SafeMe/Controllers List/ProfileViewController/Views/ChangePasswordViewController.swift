//
//  ChangePasswordViewController.swift
//  SafeMe
//
//  Created by Temur on 21/08/2023.
//

import UIKit
class ChangePasswordViewController: GradientViewController {
    
    private let bgView = UIView(.white)
    private let codeView = CodeView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let continueButton = UIButton(.custom.buttonBackgroundColor)
    
    private var phoneNumber: String
    
    let presenter = ChangePasswordPresenter()
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
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
        setupConstraints()
        presenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        codeView.timer?.startTimer()
        presenter.requestSMS(phoneNumber: phoneNumber)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        codeView.timer?.stopTimer()
    }
    
    func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [bgView] )
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [codeView,titleLabel,subtitleLabel,continueButton])
        
        bgView.layer.cornerRadius = 12
        
        titleLabel.text = "Confirmation code".localizedString
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        subtitleLabel.text = "\(phoneNumber.makeStarsInsteadNumbers())" + "enter the secret code sent to the number".localizedString
        subtitleLabel.textColor = .systemGray
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.numberOfLines = 0
        
        continueButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        continueButton.setTitle("Next".localizedString, for: .normal)
        continueButton.layer.cornerRadius = 8
        continueButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        continueButton.layer.shadowColor = UIColor.gray.cgColor
        continueButton.layer.masksToBounds = true
        continueButton.clipsToBounds = false
        continueButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        continueButton.layer.shadowRadius = 7
        continueButton.layer.shadowOpacity = 0.5
        continueButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.61),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.17),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            subtitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            codeView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            codeView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            codeView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            codeView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16),
            
            continueButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalTo: continueButton.widthAnchor, multiplier: 0.12),
            
        ])
    }
    
    @objc func nextAction() {
        presenter.checkCode(code: codeView.getCodeText())
    }
    
}

extension ChangePasswordViewController: ChangePasswordPresenterProtocol {
    func smsIsSent() {
        
    }
    
    func smsIsVerified() {
        
    }
}
