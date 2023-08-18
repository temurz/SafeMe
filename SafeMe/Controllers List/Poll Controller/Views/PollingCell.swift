//
//  PollingCell.swift
//  SafeMe
//
//  Created by Temur on 18/08/2023.
//

import UIKit
class PollingCell: UITableViewCell {
    private let bgView = UIView(.white, radius: 12)
    private let _imageView = UIImageView(.clear, radius: 8)
    private let titleLabel = UILabel()
    private let startButton = UIButton(backgroundColor: .custom.buttonBackgroundColor, textColor: .white, text: "Start".localizedString, radius: 8)
    
    var didSelectStart: (() -> ())?
    
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
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [_imageView, titleLabel, startButton])
        startButton.titleLabel?.font = .robotoFont(ofSize: 16, weight: .medium)
        startButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        _imageView.contentMode = .scaleAspectFill
        _imageView.clipsToBounds = true
        titleLabel.numberOfLines = 2
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            _imageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 12),
            _imageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 12),
            _imageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -12),
            _imageView.heightAnchor.constraint(equalToConstant: 100),
            
            startButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -12),
            startButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: _imageView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -12),
            
        ])
    }
    
    override func prepareForReuse() {
        _imageView.image = nil
        titleLabel.text = nil
    }
    
    func updateModel(_ model: PollingModel) {
        _imageView.sd_setImage(with: URL(string: model.media))
        titleLabel.text = model.text
    }
    
    @objc private func buttonAction() {
        self.didSelectStart?()
    }
}
