//
//  AboutViewController.swift
//  SafeMe
//
//  Created by Temur on 18/07/2023.
//

import UIKit
import SideMenu

class AboutViewController: BaseViewController {
    private let backgroundView = UIView(.white)
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.tag = 7
        self.title = "Biz haqqimizda"
        setupConstraints()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [backgroundView])
        backgroundView.layer.cornerRadius = 12
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -16)
        ])
    }
}
