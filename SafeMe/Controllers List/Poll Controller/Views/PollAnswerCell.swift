//
//  PollAnswerCell.swift
//  SafeMe
//
//  Created by Temur on 18/08/2023.
//

import UIKit
class PollAnswerCell: UITableViewCell {
    private let bgView = UIView(.clear, radius: 8)
    private let circleView = UIView()
    private let selectedCircleView = UIView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.selectionStyle = .none
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: bgView)
        bgView.layer.borderColor = UIColor.gray.cgColor
        bgView.layer.borderWidth = 1
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [circleView, titleLabel, selectedCircleView])
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .robotoFont(ofSize: 14, weight: .medium)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        circleView.layer.cornerRadius = 12
        circleView.layer.borderColor = UIColor.gray.cgColor
        circleView.layer.borderWidth = 1
        
        selectedCircleView.isHidden = true
        selectedCircleView.layer.cornerRadius = 9
        selectedCircleView.backgroundColor = UIColor.custom.buttonGreenBgColor
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            circleView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8),
            circleView.heightAnchor.constraint(equalToConstant: 24),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 1),
            circleView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            
            selectedCircleView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            selectedCircleView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            selectedCircleView.heightAnchor.constraint(equalToConstant: 16),
            selectedCircleView.widthAnchor.constraint(equalToConstant: 16),
            
            titleLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -8),
            
        ])
    }
    
    func updateModel(text: String) {
        titleLabel.text = text
    }
    
    func selectCell(_ bool: Bool) {
        if bool {
            selectedCircleView.isHidden = false
            circleView.layer.borderColor = UIColor.custom.buttonGreenBgColor.cgColor
        }else {
            selectedCircleView.isHidden = true
            circleView.layer.borderColor = UIColor.gray.cgColor
        }
    }
}
