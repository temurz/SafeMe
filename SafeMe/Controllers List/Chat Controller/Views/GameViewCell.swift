//
//  GameViewCell.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import UIKit

class GameViewCell: UITableViewCell {
    private let bgView = UIView(.white)
    private let mainImageView = UIImageView()
    private let subtitleLabel = UILabel(text: "", font: .robotoFont(ofSize: 12, weight: .medium), color: .gray)
    private let titleLabel = UILabel(text: "", font: .robotoFont(ofSize: 16, weight: .medium), color: .black)
    private let shareButton = UIButton(backgroundColor: .hexStringToUIColor(hex: "#1E90FF"), image: nil)
    private let saveButton = UIButton(backgroundColor: .hexStringToUIColor(hex: "#FFC600"), image: nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [mainImageView, subtitleLabel, titleLabel, shareButton, saveButton])
        self.backgroundColor = .clear
        bgView.layer.cornerRadius = 12
        
        mainImageView.layer.cornerRadius = 6
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFit
        
        shareButton.layer.cornerRadius = 5
        shareButton.setTitle("Поделиться", for: .normal)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.titleLabel?.font = .robotoFont(ofSize: 12, weight: .medium)
        shareButton.leftImage(left: 10)
        
        saveButton.layer.cornerRadius = 5
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setImage(UIImage(named: "star"), for: .normal)
        saveButton.titleLabel?.font = .robotoFont(ofSize: 12, weight: .medium)
        saveButton.leftImage(left: 10)
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            mainImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8),
            mainImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor,constant: -16),
            mainImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.47),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            subtitleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor,constant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            
            shareButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            shareButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            shareButton.widthAnchor.constraint(equalToConstant: 114),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            saveButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor, multiplier: 1),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func updateModel(model: Game) {
        mainImageView.image = UIImage(named: "gameChild")
        subtitleLabel.text = model.description
        titleLabel.text = model.name
    }
}
