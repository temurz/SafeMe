//
//  BaseViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit

class BaseViewController: UIViewController {
    private let backgroundGradientView = GradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        self.view.addSubview(backgroundGradientView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
    }
}
