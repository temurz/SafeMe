//
//  InspektorCell.swift
//  SafeMe
//
//  Created by Даулетбай Комекбаев on 21/07/23.
//

import UIKit
import SideMenu

class InspectorCell: UITableViewCell {
    
    private let telegramButton = UIButton()
    private let callButton = UIButton()
    private let phoneGreen = UIImageView()
    private let line5 = UIImageView()
    private let bgView = UIView(.white)
    private let imageInspektor = UIImageView()
    private let fullnameTitle = UILabel()
    private let subtitle = UILabel()
    private let phoneNumber = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialize()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        [bgView, imageInspektor, fullnameTitle, subtitle, phoneNumber, line5, phoneGreen, callButton, telegramButton, ].forEach {
            view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        telegramButton.setTitle("Telegram", for: .normal)
        telegramButton.setTitleColor(.white, for: .normal)
        telegramButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        telegramButton.backgroundColor = .custom.buttonBackgroundColor
        telegramButton.layer.cornerRadius = 12
        
        callButton.setTitle("Qo’ng’iroq qilish", for: .normal)
        callButton.setTitleColor(.white, for: .normal)
        callButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        callButton.backgroundColor = .custom.buttonGreenBgColor
        callButton.layer.cornerRadius = 12
        
        phoneGreen.image = UIImage(named: "phonegreen")
        phoneGreen.contentMode = .scaleAspectFit
        phoneGreen.clipsToBounds = true
        
        bgView.layer.cornerRadius = 12
        
        line5.image = UIImage(named: "lineBorder")
        line5.backgroundColor = .custom.lightGray
        line5.contentMode = .scaleAspectFit
        line5.clipsToBounds = true
        
        imageInspektor.image = UIImage(named: "inspektor1")
        imageInspektor.contentMode = .scaleAspectFit
        imageInspektor.clipsToBounds = true
        imageInspektor.layer.cornerRadius = 12
        
        phoneNumber.text = "97-430-10-44"
        phoneNumber.font = .boldSystemFont(ofSize: 16)
        
        fullnameTitle.text = "Закиров Нуриддин Абдухамидович"
        fullnameTitle.font = .boldSystemFont(ofSize: 16)
        fullnameTitle.numberOfLines = 0
        
        subtitle.text = " “Кушбеги” MFY profilaktka inspektori "
        subtitle.textColor = .systemGray
        subtitle.font = .systemFont(ofSize: 14)
        subtitle.numberOfLines = 0
        
//        callButton.backgroundColor = .customGreen
//        callButton.setTitle("Qo’ng’iroq qilish", for: .normal)
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            imageInspektor.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            imageInspektor.widthAnchor.constraint(equalToConstant: 90),
            imageInspektor.heightAnchor.constraint(equalTo: imageInspektor.widthAnchor, multiplier: 1),
            imageInspektor.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            
            fullnameTitle.leadingAnchor.constraint(equalTo: imageInspektor.trailingAnchor, constant: 12),
            fullnameTitle.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            fullnameTitle.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -24),
            
            subtitle.leadingAnchor.constraint(equalTo: fullnameTitle.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: fullnameTitle.trailingAnchor),
            subtitle.topAnchor.constraint(equalTo: fullnameTitle.bottomAnchor, constant: 18),
            
            line5.topAnchor.constraint(equalTo: imageInspektor.bottomAnchor, constant: 16),
            line5.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            line5.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            line5.heightAnchor.constraint(equalToConstant: 2),
            
            phoneGreen.widthAnchor.constraint(equalToConstant: 16),
            phoneGreen.heightAnchor.constraint(equalTo: phoneGreen.widthAnchor, multiplier: 1),
            phoneGreen.topAnchor.constraint(equalTo: line5.bottomAnchor, constant: 16),
            phoneGreen.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            
            phoneNumber.topAnchor.constraint(equalTo: line5.bottomAnchor, constant: 16),
            phoneNumber.leadingAnchor.constraint(equalTo: phoneGreen.trailingAnchor, constant: 8),
            
            callButton.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 18),
            callButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            callButton.trailingAnchor.constraint(equalTo: bgView.centerXAnchor, constant: -8),
            callButton.heightAnchor.constraint(equalToConstant: 40),
            
            telegramButton.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 18),
            telegramButton.leadingAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 8),
            telegramButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            telegramButton.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
    
    func updateModel(item: InspectorModel) {
        imageInspektor.image = UIImage(named: item.image)
        fullnameTitle.text = item.fullname
        subtitle.text = item.title
        phoneNumber.text = item.phoneNumber
    }
}
