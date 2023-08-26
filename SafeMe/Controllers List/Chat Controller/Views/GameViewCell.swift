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
    private let saveImageView = UIImageView(.clear)
    private let saveBackgroundView = GradientView()
    
    var saveAction: ((Bool) -> ())?
    private var saved: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [mainImageView, subtitleLabel, titleLabel, saveBackgroundView, saveImageView ])
        self.backgroundColor = .clear
        self.selectionStyle = .none
        bgView.layer.cornerRadius = 12
        
        mainImageView.layer.cornerRadius = 6
        
        mainImageView.layer.masksToBounds = true
        
        saveImageView.layer.cornerRadius = 6
        saveImageView.image = UIImage(named: "star")
        saveImageView.isUserInteractionEnabled = false
        saveImageView.contentMode = .scaleAspectFit
                                      
        saveBackgroundView.firstColor = UIColor(red: 0.1, green: 0.63, blue: 0.8, alpha: 1)
        saveBackgroundView.secondColor = UIColor(red: 0.1, green: 0.8, blue: 0.67, alpha: 1)
        saveBackgroundView.layer.cornerRadius = 6
        saveBackgroundView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(saveTapped))
        saveBackgroundView.addGestureRecognizer(tap)
        
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
            
            saveBackgroundView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            saveBackgroundView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            saveBackgroundView.widthAnchor.constraint(equalToConstant: 70),
            saveBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            saveImageView.topAnchor.constraint(equalTo: saveBackgroundView.topAnchor, constant: 8),
            saveImageView.leadingAnchor.constraint(equalTo: saveBackgroundView.leadingAnchor, constant: 16),
            saveImageView.trailingAnchor.constraint(equalTo: saveBackgroundView.trailingAnchor, constant: -16),
            saveImageView.bottomAnchor.constraint(equalTo: saveBackgroundView.bottomAnchor,constant: -8),
        ])
    }
    
    @objc private func saveTapped() {
        saved = !saved
        saveImageView.image = saved ? UIImage(named: "star")?.withTintColor(UIColor.hexStringToUIColor(hex: "#FFC600")) : UIImage(named: "star")
        saveAction?(saved)
    }
    
    func updateModel(model: Game, saved: Bool) {
        self.saved = saved
        saveImageView.image = saved ? UIImage(named: "star")?.withTintColor(UIColor.hexStringToUIColor(hex: "#FFC600")) : UIImage(named: "star")
        mainImageView.sd_setImage(with: URL(string: model.image ?? ""))
        subtitleLabel.text = model.description
        titleLabel.text = model.name
    }
}
