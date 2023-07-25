//
//  AgeFilterCell.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import UIKit

class AgeFilterCell: UICollectionViewCell {
    private let ageLabel = UILabel()
    private var bottomLine = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.contentView.backgroundColor = .clear
        
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        bottomLine.isHidden = true
        self.layer.addSublayer(bottomLine)
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: ageLabel)
        
        ageLabel.font = .systemFont(ofSize: 16)
        ageLabel.textColor = self.isSelected ? .white : UIColor.white.withAlphaComponent(0.74)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])
    }
    
    func updateModel(text: String) {
        ageLabel.text = text
    }
    
    func makeSelected(bool: Bool) {
        if bool {
            ageLabel.textColor = .white
            bottomLine.isHidden = false
        }else {
            ageLabel.textColor = .white.withAlphaComponent(0.74)
            bottomLine.isHidden = true
        }
        
    }
    
    
}
