//
//  NewsCell.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import UIKit

class NewsCell: UITableViewCell {
    private let bgView = UIView()
    private let mainImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let hexLabel = UILabel()
    private let dateLabel = UILabel()
    private let viewsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.backgroundColor = .clear
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, array: [bgView, mainImageView, titleLabel, subtitleLabel, hexLabel])
        bgView.layer.borderWidth = 4
        bgView.backgroundColor = .white
        bgView.layer.borderColor = UIColor.hexStringToUIColor(hex: "#63D586").cgColor
        bgView.layer.cornerRadius = 12
        
        mainImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.textColor = .custom.gray
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.numberOfLines = 0
        
        hexLabel.font = .systemFont(ofSize: 12, weight: .regular)
        hexLabel.textColor = .custom.gray
        hexLabel.numberOfLines = 0
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            mainImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            mainImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            mainImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            hexLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            hexLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            hexLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),

            
        ])
    }
    
    func updateModel(model: News) {
        mainImageView.sd_setImage(with: URL(string: model.image))
        titleLabel.text = model.title
        subtitleLabel.text = model.shortText
//        bgView.layer.borderColor = UIColor.hexStringToUIColor(hex: model.borderColor).cgColor
    }
}
