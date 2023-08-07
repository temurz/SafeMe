//
//  CategoryCell.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import UIKit
public enum CategoryType {
    case game
    case recommendation
}

class CategoryCell: UICollectionViewCell {
    private let bgView = UIView(.clear, radius: 12)
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private var categoryType = CategoryType.recommendation
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.contentView.backgroundColor = .clear
        SetupViews.addViewEndRemoveAutoresizingMask(superView: self.contentView, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [imageView, titleLabel, arrowImageView])
        bgView.backgroundColor = UIColor.hexStringToUIColor(hex: "#63D586")
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.masksToBounds = true
        bgView.clipsToBounds = false
        bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        bgView.layer.shadowRadius = 7
        bgView.layer.shadowOpacity = 0.5
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .robotoFont(ofSize: 14, weight: .medium)
        
        arrowImageView.image = UIImage(named: "chevron_right")
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            imageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor,  constant: 16),
            imageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            arrowImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            arrowImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            arrowImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -16)
        ])
    }
    
    func updateModel(model: Category, type: CategoryType = .recommendation) {
        self.imageView.sd_setImage(with: URL(string: model.icon))
        self.titleLabel.text = model.title
        if model.id % 2 == 0 {
            self.bgView.backgroundColor = UIColor.hexStringToUIColor(hex: "#C7A9F5")
        }else {
            self.bgView.backgroundColor = UIColor.hexStringToUIColor(hex: "#63D586")
        }
        
        if type == .game {
            arrowImageView.isHidden = true
            self.bgView.backgroundColor = .white
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16).isActive = true
        }
        
        
    }
}
