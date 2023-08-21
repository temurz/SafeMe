//
//  CodeView.swift
//  SafeMe
//
//  Created by Temur on 08/08/2023.
//

import Foundation
import UIKit

final class CodeView: UIView {
//    lazy var codeInformationLabel = UILabel(text: "На ваш номер \(username ?? "") был направлен код подтверждения, введите его ниже", ofSize: 17, weight: .regular, color: .custom.black)
//    private lazy var codeLabel = UILabel(text: "Код", ofSize: 22, weight: .bold, color: .custom.black)
    private lazy var stackView = UIStackView()
    private lazy var textField = UITextField()
    private lazy var labelOne = UILabel(text: "", ofSize: 24, weight: .bold, color: .custom.black)
    private lazy var labelTwo = UILabel(text: "", ofSize: 24, weight: .bold, color: .custom.black)
    private lazy var labelThree = UILabel(text: "", ofSize: 24, weight: .bold, color: .custom.black)
    private lazy var labelFour = UILabel(text: "", ofSize: 24, weight: .bold, color: .custom.black)
    private lazy var bottomLabel = UILabel(text: bottomText ?? "", font: .montserratFont(ofSize: 13, weight: .regular), color: .custom.gray)
    var isButtonAvailableAction: ((Bool) -> ())?
    let timerButton = UIButton(.clear)
    var timer: TimerView?
    
    var requestSMS: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var username: String? = "" {
//        didSet {
//            codeInformationLabel.text = "На ваш \(username ?? "") был направлен код подтверждения, введите его ниже"
//            makeConstraints()
//        }
//    }
    
    var bottomText: String? = "" {
        didSet {
            bottomLabel.text = bottomText
            makeConstraints()
        }
    }
    
    private func setupView() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: self, array: [stackView, textField, bottomLabel, timerButton])
        timer = TimerView.loadingCountDownTimerInView(_superView: timerButton)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: timerButton, view: timer!)
        
        timer?.requestSmsAction = { [weak self] in
            self?.requestSMS?()
        }
        
        let viewOne = UIView(.custom.lightGray)
        viewOne.addSubview(labelOne)
        let viewTwo = UIView(.custom.lightGray)
        viewTwo.addSubview(labelTwo)
        let viewThree = UIView(.custom.lightGray)
        viewThree.addSubview(labelThree)
        let viewFour = UIView(.custom.lightGray)
        viewFour.addSubview(labelFour)
        
        [labelOne, labelTwo, labelThree, labelFour].forEach { label in
            label.fullConstraint()
            label.textAlignment = .center
        }
        
        [viewOne, viewTwo, viewThree, viewFour].forEach { view in
            view.layer.cornerRadius = 10
            view.backgroundColor = .custom.lightGray
            
            stackView.addArrangedSubview(view)
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 22
        stackView.isUserInteractionEnabled = false
        
        textField.isUserInteractionEnabled = true
        textField.textColor = .clear
        textField.tintColor = .clear
        textField.keyboardType = .numberPad
        textField.addToolBar(self, action: #selector(doneAction), title: "Готово".localizedString)
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .center
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 61),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            
            textField.topAnchor.constraint(equalTo: stackView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            bottomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bottomLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            timerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            timerButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            timerButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            timerButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
        
        timer?.fullConstraint()
        TimerView.Stored.timerLabel.fullConstraint()
    }
    
    //MARK: - Actions
    
    @objc private func doneAction() {
        self.endEditing(true)
    }
    
    func getCodeText() -> String {
        return textField.text ?? ""
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 4 {
                self.isButtonAvailableAction?(true)
            }else if text.count > 4 {
                self.isButtonAvailableAction?(true)
                textField.text?.removeLast()
                self.endEditing(true)
            }else if text.count < 4 {
                self.isButtonAvailableAction?(false)
            }
            if text.count == 0 {
                self.labelOne.text = ""
            }
            for i in 0..<text.count {
                switch i {
                case 0:
                    self.labelOne.text = text[i]
                    self.labelTwo.text = ""
                    self.labelThree.text = ""
                    self.labelFour.text = ""
                case 1:
                    self.labelTwo.text = text[i]
                    self.labelThree.text = ""
                    self.labelFour.text = ""
                case 2:
                    self.labelThree.text = text[i]
                    self.labelFour.text = ""
                case 3:
                    self.labelFour.text = text[i]
                default:
                    break
                }
            }
        }
    }
}
