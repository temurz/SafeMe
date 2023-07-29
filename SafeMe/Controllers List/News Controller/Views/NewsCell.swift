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
    private let dateView = UIButton(UIColor.custom.dateBackgroundColor)
    private let eyeView = UIButton(UIColor.custom.dateBackgroundColor)
    private let calendarImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, array: [bgView, mainImageView, titleLabel, subtitleLabel, dateView, eyeView])
        bgView.layer.borderWidth = 4
        bgView.backgroundColor = .white
        bgView.layer.borderColor = UIColor.hexStringToUIColor(hex: "#63D586").cgColor
        bgView.layer.cornerRadius = 12
        
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.layer.cornerRadius = 6
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.textColor = .custom.gray
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .natural
        
        
        dateView.setImage(UIImage(named: "calendar"), for: .normal)
        
        dateView.setTitle("23.08.2023", for: .normal)
        dateView.setTitleColor(.custom.grayDate, for: .normal)
        dateView.titleLabel?.font = .robotoFont(ofSize: 13, weight: .medium)
        dateView.leftImage()
        dateView.layer.cornerRadius = 5
        dateView.isUserInteractionEnabled = false
        
        eyeView.isUserInteractionEnabled = false
        eyeView.setImage(UIImage(named: "visibility"), for: .normal)
        eyeView.setTitle("0", for: .normal)
        eyeView.setTitleColor(.custom.grayDate, for: .normal)
        eyeView.titleLabel?.font = .robotoFont(ofSize: 13, weight: .medium)
        eyeView.leftImage(left: 10, right: 10)
        eyeView.layer.cornerRadius = 5
        eyeView.titleLabel?.textAlignment = .center
        eyeView.titleLabel?.numberOfLines = 0
        
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
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: dateView.topAnchor, constant: -12),
            
            dateView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            dateView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            dateView.heightAnchor.constraint(equalToConstant: 30),
            dateView.widthAnchor.constraint(equalToConstant: 100),
            
            eyeView.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: 12),
            eyeView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            eyeView.widthAnchor.constraint(equalToConstant: 60),
            eyeView.heightAnchor.constraint(equalToConstant: 30)

            
        ])
    }
    
    func updateModel(model: News) {
        mainImageView.sd_setImage(with: URL(string: model.image))
        titleLabel.text = model.title
        subtitleLabel.text = model.shortText
        dateView.setTitle(model.createdDate.convertToDateUS(), for: .normal) 
        eyeView.setTitle("\(model.views)", for: .normal)
        if model.views > 100 {eyeView.leftImage()}
//        bgView.layer.borderColor = UIColor.hexStringToUIColor(hex: model.borderColor).cgColor
    }
}
