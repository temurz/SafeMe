//
//  SosViewController.swift
//  SafeMe
//
//  Created by Temur on 27/07/2023.
//

import UIKit

class SosViewController: GradientViewController {
    
    private let firstCallButton = UIButton()
    private let secondCallButton = UIButton()
    private let thirdCallButton = UIButton()
    private let sosLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SOS"
        setupConstraints()
        
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [firstCallButton, secondCallButton, thirdCallButton, sosLabel ])
        
        sosLabel.textColor = .white
        sosLabel.backgroundColor = .clear
        sosLabel.text = "SOS"
        sosLabel.font = .systemFont(ofSize: 72, weight: .medium)
        
        firstCallButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#FFC600")
        firstCallButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        firstCallButton.setTitle("Shubhali holatlar mavjud", for: .normal)
        firstCallButton.addTarget(self, action: #selector(firstCallButtonAction), for: .touchUpInside)
        firstCallButton.layer.cornerRadius = 12
        firstCallButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#6F2B15"), for: .normal)
        
        secondCallButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#FFA607")
        secondCallButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        secondCallButton.setTitle("Xavfli hududga borayapman", for: .normal)
        secondCallButton.layer.cornerRadius = 12
        secondCallButton.addTarget(self, action: #selector(secondCallButtonAction), for: .touchUpInside)
        secondCallButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#7A4E00"), for: .normal)
        
        thirdCallButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#E15C2F")
        thirdCallButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        thirdCallButton.setTitle("Xoziroq yordam kerak", for: .normal)
        thirdCallButton.layer.cornerRadius = 12
        thirdCallButton.addTarget(self, action: #selector(thirdCallButtonAction), for:
                .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            sosLabel.bottomAnchor.constraint(equalTo: firstCallButton.topAnchor, constant: -140),
            sosLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstCallButton.bottomAnchor.constraint(equalTo: secondCallButton.topAnchor, constant: -24),
            firstCallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstCallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstCallButton.heightAnchor.constraint(equalTo: firstCallButton.widthAnchor, multiplier: 0.17),
            
            secondCallButton.bottomAnchor.constraint(equalTo: thirdCallButton.topAnchor, constant: -24),
            secondCallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondCallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondCallButton.heightAnchor.constraint(equalTo: secondCallButton.widthAnchor, multiplier: 0.17),
            
            thirdCallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            thirdCallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            thirdCallButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            thirdCallButton.heightAnchor.constraint(equalTo: thirdCallButton.widthAnchor, multiplier: 0.35),
            
        ])
    }
    
    @objc private func firstCallButtonAction() {
//        let vc = SosViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        print("Shubhali holatlar mavjud!")
    }
    
    @objc private func secondCallButtonAction() {
//        let vc = SosViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        print("Xavfli hududga borayapman!")
    }
    
    @objc private func thirdCallButtonAction() {
//        let vc = SosViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        print("Hozir yordam kerak!")
    }
}
