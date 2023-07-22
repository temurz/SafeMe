//
//  AuthCell.swift
//  SafeMe
//
//  Created by Temur on 22/07/2023.
//

import Foundation

import UIKit

enum TypeMenu {
    case login
    case pass
    
    var string: String {
        switch self {
        case .login: return "Login".localizedString
        case .pass: return String.localized.password
        }
    }
}

protocol UIAuthCellProtocol:AnyObject  {
    func editing(_ type: TypeMenu, text: String)
    func textFieldDidEndEditing(_ type: TypeMenu, text: String)
    func textFieldDidBeginEditing(_ type: TypeMenu, text: String)
}

class UIAuthCell:UIView, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    
    weak var delegate:UIAuthCellProtocol? {
        didSet {
            if delegate != nil {
                textField.delegate = self
            }
        }
    }
    
    private lazy var imagViewEye:UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "eye"))
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .customGray
        return imageView
    }()
    
    private var statusPasswordText:FilterStatus = .closed {
        didSet {
            if type != .pass {return}
            textField.isSecureTextEntry = statusPasswordText == .closed
            imagViewEye.image = statusPasswordText == .closed ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        }
    }
    
    public var text:String {
        get {textField.text ?? ""}
        set {textField.text = newValue}
    }
    
    private var type:TypeMenu = .login
    
    private lazy var label:UILabel! = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.backgroundColor = .custom.white
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    @objc private func actionEye() {
        statusPasswordText = statusPasswordText == .open ? .closed : .open
    }
    
    private lazy var textField:UITextField! = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.backgroundColor = .clear
        textField.autocorrectionType = .no
        textField.placeholderColor = .customGray3
        textField.autocapitalizationType = .none
        return textField
    }()
    
    convenience init(title:TypeMenu, text:String?) {
        self.init()
        self.type = title
        self.label.text = title.string
        self.textField.placeholder = title == .pass ? String.localized.password : "Email or phone number".localizedString
        self.textField.text = text
        self.textField.autocorrectionType = .no
        self.textField.isSecureTextEntry = title == .pass
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        let viewBorder = UIView()
        viewBorder.backgroundColor = .custom.white
        viewBorder.layer.borderWidth = 1
        viewBorder.layer.borderColor = UIColor.systemGray3.cgColor
        viewBorder.layer.cornerRadius = 15
        self.addSubview(viewBorder)
        self.addSubview(label)
        self.addSubview(textField)
        [viewBorder, label, textField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            viewBorder.topAnchor.constraint(equalTo: viewBorder.superview!.topAnchor, constant: 10),
            viewBorder.bottomAnchor.constraint(equalTo: viewBorder.superview!.bottomAnchor, constant: -10),
            viewBorder.leadingAnchor.constraint(equalTo: viewBorder.superview!.leadingAnchor, constant: 10),
            viewBorder.trailingAnchor.constraint(equalTo: viewBorder.superview!.trailingAnchor, constant: -10),
            
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.leadingAnchor.constraint(equalTo: viewBorder.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(lessThanOrEqualTo: viewBorder.trailingAnchor),
            label.widthAnchor.constraint(equalToConstant: 70),
            
            textField.topAnchor.constraint(equalTo: viewBorder.topAnchor),
            textField.bottomAnchor.constraint(equalTo: viewBorder.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: viewBorder.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: viewBorder.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        if type == .pass {
            let view = UIView(.clear)
            view.addSubview(imagViewEye)
            let tap = UITapGestureRecognizer(target: self, action: #selector(actionEye))
            tap.delegate = self
            view.addGestureRecognizer(tap)
            view.translatesAutoresizingMaskIntoConstraints = false
            imagViewEye.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: textField.topAnchor),
                view.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
                view.trailingAnchor.constraint(equalTo: viewBorder.trailingAnchor),
                view.widthAnchor.constraint(equalTo: imagViewEye.heightAnchor, multiplier: 1),
                
                imagViewEye.topAnchor.constraint(equalTo: view.topAnchor, constant: 7),
                imagViewEye.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -7),
                imagViewEye.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
                imagViewEye.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
            ])
        }
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(self.type, text: textField.text ?? "")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(self.type, text: textField.text ?? "")
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.editing(self.type, text: textField.text ?? "")
    }
}
