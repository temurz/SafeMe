//
//  LanguageViewCell.swift
//  SafeMe
//
//  Created by Temur on 19/08/2023.
//

import UIKit
class LanguageViewCell: UITableViewCell {
    private let bgView = UIView(.clear, radius: 12)
    private let languageImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.backgroundColor = .clear
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [languageImageView, titleLabel])
        languageImageView.layer.cornerRadius = 12
        languageImageView.clipsToBounds = true
        
        titleLabel.textColor = .black
        
        bgView.layer.borderColor = UIColor.gray.cgColor
        bgView.layer.borderWidth = 1
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            languageImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8),
            languageImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            languageImageView.widthAnchor.constraint(equalToConstant: 24),
            languageImageView.heightAnchor.constraint(equalTo: languageImageView.widthAnchor, multiplier: 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: languageImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
        ])
    }
    
    func updateModel(image: String, language: String) {
        titleLabel.text = language
        languageImageView.image = UIImage(named: image)
    }
}
