//
//  ApplicationCodeViewController.swift
//  SafeMe
//
//  Created by Temur on 23/07/2023.
//

import UIKit
import SideMenu

enum ButtonCheckState {
    case pin
    case confirmationCode
}

final class ApplicationCodeViewController: GradientViewController {
    private let bgView = UIView()
    private let titleLabel = UILabel(text: "PIN".localizedString, ofSize: 20, weight: .medium, color: .custom.black)
    private let subtitleLabel = UILabel(text: "Enter Pin Code".localizedString, ofSize: 16, weight: .regular, color: .custom.gray)
    private let stackView = UIStackView(.horizontal, .fillEqually, .fill, 8, [])
    private let textField = UITextField()
    private let nextButton = UIButton(backgroundColor: UIColor.custom.lightGray, textColor: .custom.white, text: "Next".localizedString, radius: 12)
    private let forgotPinButton = UIButton(.clear)
    private let codeView = CodeView()
    private var buttonCheckState: ButtonCheckState = .pin
    private let backButton = UIButton(backgroundColor: .clear, textColor: .custom.blue, text: "Back".localizedString)
    var hasPin: Bool
    
    private let presenter = AppEnterCodePresenter()
    
    let roundViewOne = UIView(.black)
    let roundViewTwo = UIView(.black)
    let roundViewThree = UIView(.black)
    let roundViewFour = UIView(.black)
    
    init(hasPin: Bool) {
        self.hasPin = hasPin
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
        textField.becomeFirstResponder()
    }
    
    private func initialize() {
        bgView.layer.cornerRadius = 12
        bgView.backgroundColor = .white
        bgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bgView)
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, subtitleLabel, stackView, textField, nextButton, forgotPinButton, backButton, codeView])
        
        subtitleLabel.numberOfLines = 0
        
        forgotPinButton.contentHorizontalAlignment = .right
        forgotPinButton.setTitle("Did you forget PIN?".localizedString, for: .normal)
        forgotPinButton.setTitleColor(.custom.gray, for: .normal)
        forgotPinButton.isHidden = hasPin ? false : true
        forgotPinButton.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
        forgotPinButton.titleLabel?.font = .robotoFont(ofSize: 16)
        
        subtitleLabel.text = hasPin ? subtitleLabel.text : "Create new PIN".localizedString
        
        codeView.isHidden = true
        codeView.requestSMS = { [weak self] in
            guard let self else { return }
            self.presenter.requestSMSForPin()
        }
        
        codeView.isButtonAvailableAction = { [weak self] bool in
            guard let self else { return }
            self.makeNextButtonAvailable(bool)
        }
        
        let viewOne = UIView()
        
        viewOne.addSubview(roundViewOne)
        let viewTwo = UIView()
        
        viewTwo.addSubview(roundViewTwo)
        let viewThree = UIView()
        
        viewThree.addSubview(roundViewThree)
        let viewFour = UIView()
        
        viewFour.addSubview(roundViewFour)
        
        [roundViewOne, roundViewTwo, roundViewThree, roundViewFour].forEach { roundView in
            //            roundView.layer.cornerRadius = (roundView.superview?.frame.height ?? 62) / 2
            roundView.translatesAutoresizingMaskIntoConstraints = false
            //            roundView.fullConstraint(top: 14,bottom: -14,leading: 14,trailing: -14)
            roundView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            roundView.widthAnchor.constraint(equalToConstant: 24).isActive  = true
            if let superView = roundView.superview {
                NSLayoutConstraint.activate([
                    roundView.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
                    roundView.centerYAnchor.constraint(equalTo: superView.centerYAnchor)
                ])
            }
            
            roundView.layer.cornerRadius = 12
            
        }
        
        [viewOne, viewTwo, viewThree, viewFour].forEach { view in
            
            view.layer.borderColor = UIColor.custom.black.cgColor
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 2
            stackView.addArrangedSubview(view)
        }
        
        textField.tintColor = .clear
        textField.textColor = .clear
        textField.keyboardType = .numberPad
        textField.addToolBar(self, action: #selector(doneAction), title: "Done".localizedString)
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        backButton.isHidden = true
        backButton.contentHorizontalAlignment = .right
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            stackView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 62),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width*0.6),
            
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPinButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            forgotPinButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            forgotPinButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            forgotPinButton.heightAnchor.constraint(equalToConstant: 32),
            
            backButton.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            codeView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            codeView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            codeView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            codeView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
        ])
        
        textField.fullConstraint(view: stackView)
        
    }
    
    @objc private func doneAction() {
        textField.endEditing(true)
    }
    
    @objc private func forgotAction() {
        presenter.requestSMSForPin()
    }
    
    @objc private func backAction() {
        showCodeConfirmation(false)
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 4 {
                //                self.isButtonAvailableAction?(true)
                makeNextButtonAvailable(true)
            }else if text.count > 4 {
                //                self.isButtonAvailableAction?(true)
                makeNextButtonAvailable(true)
                textField.text?.removeLast()
                textField.endEditing(true)
            }else if text.count < 4 {
                //                self.isButtonAvailableAction?(false)
                makeNextButtonAvailable(false)
            }
            if text.count == 0 {
                roundViewOne.backgroundColor = .custom.green
                [roundViewOne, roundViewTwo, roundViewThree, roundViewFour].forEach { view in
                    view.backgroundColor = .black
                    view.superview?.layer.borderColor = UIColor.black.cgColor
                }
                
            }
            for i in 0..<text.count {
                switch i {
                case 0:
                    if let view = self.stackView.arrangedSubviews.first {
                        view.layer.borderColor = UIColor.custom.green.cgColor
                    }
                    roundViewOne.backgroundColor = .custom.green
                    [roundViewTwo, roundViewThree, roundViewFour].forEach { view in
                        view.backgroundColor = .black
                        view.superview?.layer.borderColor = UIColor.black.cgColor
                    }
                case 1:
                    self.stackView.arrangedSubviews[1].layer.borderColor = UIColor.custom.green.cgColor
                    roundViewTwo.backgroundColor = .custom.green
                    [roundViewThree, roundViewFour].forEach { view in
                        view.backgroundColor = .black
                    }
                case 2:
                    stackView.arrangedSubviews[2].layer.borderColor = UIColor.custom.green.cgColor
                    roundViewThree.backgroundColor = .custom.green
                    roundViewFour.backgroundColor = .black
                case 3:
                    stackView.arrangedSubviews[3].layer.borderColor = UIColor.custom.green.cgColor
                    roundViewFour.backgroundColor = .custom.green
                default:
                    break
                }
            }
        }
    }
    
    private func showCodeConfirmation(_ bool: Bool) {
        self.view.endEditing(true)
        if !bool {
            codeView.timer?.stopTimer()
            textDidChange(self.textField)
        }else {
            codeView.timer?.startTimer()
            codeView.clear()
            makeNextButtonAvailable(false)
        }
        buttonCheckState = bool ? .confirmationCode : .pin
        codeView.isHidden = !bool
        
        backButton.isHidden = !bool
        titleLabel.text = bool ? "Confirmation code".localizedString : "PIN".localizedString
        subtitleLabel.text = bool ? "Enter the secret code sent to your number".localizedString : "Enter Pin Code".localizedString
        
        stackView.isHidden = bool
        textField.isHidden = bool
        forgotPinButton.isHidden = bool
    }
    
    private func makeNextButtonAvailable(_ bool: Bool) {
        if bool {
            self.nextButton.backgroundColor = UIColor.custom.buttonBackgroundColor
            self.nextButton.isUserInteractionEnabled = true
        }else {
            self.nextButton.backgroundColor = .custom.lightGray
            self.nextButton.isUserInteractionEnabled = false
        }
    }
    
    @objc private func nextAction() {
        if buttonCheckState == .pin {
            if presenter.compareEnterCode(enterCode: textField.text ?? "") {
                let vc = SuggestionsViewController()
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                let navController = SideMenuNavigationController(rootViewController: vc)
                keyWindow?.rootViewController = navController
                return
            }
            if AuthApp.shared.appEnterCode == nil {
                if let text = textField.text {
                    presenter.saveEnterCode(enterCode: text)
                    subtitleLabel.text = "Confirm Pin".localizedString
                    textField.text = ""
                    textDidChange(textField)
                }
            }else if !presenter.compareEnterCode(enterCode: textField.text ?? "") {
                alert(title: "Wrong PIN".localizedString, message: "Enter PIN again", url: nil)
                textField.text = ""
                textDidChange(textField)
            }
        }else {
            presenter.checkSMSCodeForPin(code: codeView.getCodeText())
        }
        
    }
}

extension ApplicationCodeViewController: AppEnterCodePresenterProtocol {
    func success(sessionId: String) {
        showCodeConfirmation(true)
    }
    
    func successSMSVerification() {
        AuthApp.shared.appEnterCode = nil
        showCodeConfirmation(false)
        forgotPinButton.isHidden = true
        subtitleLabel.text = "Create new PIN".localizedString
    }
}
