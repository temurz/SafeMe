//
//  RecommendationCell.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import UIKit

class RecommendationCell: UICollectionViewCell {
    private let bgView = UIView(.clear, radius: 12)
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
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
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [imageView, titleLabel])
        bgView.backgroundColor = .white
        bgView.layer.shadowColor = UIColor.gray.cgColor
        bgView.layer.masksToBounds = true
        bgView.clipsToBounds = false
        bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        bgView.layer.shadowRadius = 7
        bgView.layer.shadowOpacity = 0.5
        
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        
        titleLabel.numberOfLines = 2
        titleLabel.font = .robotoFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            imageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor,  constant: 8),
            imageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.41),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16)
        ])
    }
    
    func updateModel(model: Recommendation) {
        self.imageView.sd_setImage(with: URL(string: model.image ?? ""))
        self.titleLabel.text = model.title
        
    }
}
