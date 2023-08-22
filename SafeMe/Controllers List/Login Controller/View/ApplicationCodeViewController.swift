//
//  ApplicationCodeViewController.swift
//  SafeMe
//
//  Created by Temur on 23/07/2023.
//

import UIKit
import SideMenu

enum ButtonCheckState {
    case firstCode
    case secondCode
}

final class ApplicationCodeViewController: GradientViewController {
    private let bgView = UIView()
    private let titleLabel = UILabel(text: "PIN".localizedString, ofSize: 20, weight: .medium, color: .custom.black)
    private let subtitleLabel = UILabel(text: "Enter Pin Code".localizedString, ofSize: 16, weight: .regular, color: .custom.gray)
    private let stackView = UIStackView(.horizontal, .fillEqually, .fill, 8, [])
    private let textField = UITextField()
    private let nextButton = UIButton(backgroundColor: UIColor.custom.lightGray, textColor: .custom.white, text: "Next".localizedString, radius: 12)
    private var buttonCheckState: ButtonCheckState = .firstCode
    private let presenter = AppEnterCodePresenter()
    
    let roundViewOne = UIView(.black)
    let roundViewTwo = UIView(.black)
    let roundViewThree = UIView(.black)
    let roundViewFour = UIView(.black)
    
    
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
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
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, subtitleLabel, stackView, textField, nextButton])
        
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
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        textField.fullConstraint(view: stackView)
        
    }
    
    @objc private func doneAction() {
        textField.endEditing(true)
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 4 {
                //                self.isButtonAvailableAction?(true)
                self.nextButton.backgroundColor = UIColor.custom.buttonBackgroundColor
                self.nextButton.isUserInteractionEnabled = true
            }else if text.count > 4 {
                //                self.isButtonAvailableAction?(true)
                self.nextButton.backgroundColor = UIColor.custom.buttonBackgroundColor
                self.nextButton.isUserInteractionEnabled = true
                textField.text?.removeLast()
                textField.endEditing(true)
            }else if text.count < 4 {
                //                self.isButtonAvailableAction?(false)
                self.nextButton.backgroundColor = .custom.lightGray
                self.nextButton.isUserInteractionEnabled = false
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
    
    @objc private func nextAction() {
        
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
    }
}
