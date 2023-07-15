//
//  UICustomTextField.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit
@objc protocol UICustomTextFieldDelegate: AnyObject {
    @objc optional func customTextField(_ customTextField:UICustomTextField, changed text: String?)
    @objc optional  func customTextField(_ customTextField:UICustomTextField, didBegin text: String?)
    @objc optional  func customTextField(_ customTextField:UICustomTextField, doneButton text: String?)
    @objc optional  func customTextField(_ customTextField:UICustomTextField, endEditing text: String?)
}
class UICustomTextField: UIView, UITextFieldDelegate {
    weak var delegate: UICustomTextFieldDelegate?
    private lazy var view = UIView(.custom.lightGray)
    private lazy var typeLabel: UILabel = UILabel(text: "", ofSize: 10, weight: .regular, color: .custom.gray)
    private lazy var starLabel: UILabel = UILabel(text: "*", ofSize: 10, weight: .regular, color: .custom.red)
    private lazy var errorLabel: UILabel = UILabel(text: "", ofSize: 12, weight: .regular, color: .custom.red)
    private lazy var textField:UITextField! = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .montserratFont(ofSize: 15, weight: .regular)
        textField.backgroundColor =  .clear
        textField.placeholderColor = .custom.gray3
        textField.indent(size: 16)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.addToolBar(self, action: #selector(doneAction), title: "Готово")
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
        textField.delegate = self
        return textField
    }()
    
    var isOnPlacholderAnimation: Bool = false {
        willSet {
            let string = textField.text ?? ""
            if newValue {
                typeLabel.isHidden = string.isEmpty
                starLabel.isHidden = string.isEmpty
            } else {
                typeLabel.isHidden = false
                starLabel.isHidden = false
            }
        }
    }
    
    var isSecureTextField: Bool = false {
        willSet {
            if newValue {
                textField.isSecureTextEntry = true
            } else {
                textField.isSecureTextEntry = false
            }
        }
    }
    
    var borderColor: UIColor? = nil {
        willSet {
            guard let newValue = newValue else {self.view.layer.borderWidth = 0; return}
            view.layer.borderColor = newValue.cgColor
            view.layer.borderWidth = 1
        }
    }
    
    convenience init(title: String, star:Bool, text: String?, placeholder: String?, height: CGFloat = 44.0) {
        self.init(frame: .zero)
        setupView(height)
        self.typeLabel.text = title
        self.textField.placeholder = placeholder
        self.textField.text = text
        textField.contentVerticalAlignment = .bottom
        textField.contentMode = .bottom
        self.starLabel.isHidden = !star
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        textField.autocapitalizationType = .words
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(_ height: CGFloat = 44.0) {
        self.backgroundColor = .clear
        view.layer.borderColor = UIColor.custom.blue.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        let errorViewLabel = UIView(.clear)
        errorViewLabel.addSubview(errorLabel)
        errorLabel.fullConstraint(top: 0, bottom: 0, leading: 16, trailing: -16)
        
        let stackView = UIStackView(.vertical, .fill, .fill, 8, [view, errorViewLabel])
        errorViewLabel.isHidden = true
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [typeLabel, starLabel, textField])
        self.addSubview(stackView)
        stackView.fullConstraint()
        errorLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height),
            errorLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 12),
            
            typeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            typeLabel.heightAnchor.constraint(equalToConstant: 10),
            
            starLabel.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            starLabel.bottomAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            starLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            starLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),

            textField.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        let string = textField.text ?? ""
        if isOnPlacholderAnimation {
            typeLabel.isHidden = string.isEmpty
            starLabel.isHidden = string.isEmpty
        }
    }
}

//MARK: - Публичные переменные
extension UICustomTextField {
    
    var contentVerticalAlignment: UIControl.ContentVerticalAlignment {get {textField.contentVerticalAlignment} set {textField.contentVerticalAlignment = newValue}}
    var keyboardType: UIKeyboardType {get {textField.keyboardType} set {textField.keyboardType = newValue}}
    var isEmpty: Bool {textField.text?.isEmpty ?? true}
    var star:Bool {get{!(starLabel.text ?? "").isEmpty} set {starLabel.text = newValue ? "*" : ""}}
    //текст над текстовым полем
    var title: String? {get {return typeLabel.text}set {typeLabel.text = newValue}}
    var placeholder: String? {get {return textField.placeholder}set {textField.placeholder = newValue}}
    var text: String {get {return textField.text ?? ""}set {textField.text = newValue}}
    var font: UIFont? {get {return textField.font}set {textField.font = newValue}}
    var infomationLabelFont: UIFont {get {return typeLabel.font}set {typeLabel.font = newValue}}
    var isHiddenInfomationLabel: Bool{ get {typeLabel.isHidden} set {typeLabel.isHidden = newValue} }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get { return textField.autocapitalizationType }
        set { textField.autocapitalizationType = newValue }
    }
    
    //текст ошибки
    var errorString: String {
        get { errorLabel.text ?? "" }
        set {
            errorLabel.text = newValue
        }
    }
    
    var isOnError: Bool {
        get { !errorLabel.superview!.isHidden }
        set {
            errorLabel.superview!.isHidden = !newValue
        }
    }
}


//MARK: - Публичные методы
extension UICustomTextField {
    //нажатие кнопки ГОТОВО
    @objc private func doneAction() {
        delegate?.customTextField?(self, doneButton: textField.text)
        self.superview?.endEditing(true) }
    
    //редактирование текстового поля
    @objc func textFieldChanged(_ textField:UITextField) {
        delegate?.customTextField?(self, changed: textField.text)
    }
    
    //наведение на поле редактирования
    @objc func editingDidBegin(_ textField:UITextField) {
        delegate?.customTextField?(self, didBegin: textField.text)
    }
    
    //конец редактирования
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.customTextField?(self, endEditing: textField.text)
    }
}
