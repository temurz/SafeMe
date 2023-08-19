//
//  MenuCell.swift
//  SafeMe
//
//  Created by Temur on 18/07/2023.
//

import UIKit

class MenuCell: UITableViewCell {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private var model = MenuModel(id: 0, image: "suggestions", title: "Tavsiyalar".localizedString)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, array: [iconImageView, titleLabel])
        titleLabel.font = .boldSystemFont(ofSize: 16)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])
    }
    
    func updateModel(model: MenuModel, currentRow: Int) {
        self.model = model
        if model.image == "suggestions" {
            iconImageView.image = UIImage(named: model.image)?.withTintColor(.black)
        }else {
            iconImageView.image = UIImage(named: model.image)
        }
        if currentRow == model.id {
            self.contentView.backgroundColor = .custom.cellBackgroundColor
            self.changeSelectedStyle(selected: true)
        }
        titleLabel.text = model.title
    }
    
    func changeSelectedStyle(selected: Bool) {
        iconImageView.image = selected ? UIImage(named: model.image)?.withTintColor(.white) : UIImage(named: model.image)
        titleLabel.textColor = selected ? .white : .black
    }
}
