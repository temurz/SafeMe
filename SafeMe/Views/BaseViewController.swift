//
//  BaseViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit

class BaseViewController: UIViewController {
    let backgroundGradientView = GradientView()
    
    override func loadView() {
        super.loadView()
        backgroundGradientView.translatesAutoresizingMaskIntoConstraints = false
        backgroundGradientView.firstColor = UIColor(red: 0.1, green: 0.63, blue: 0.8, alpha: 1)
        backgroundGradientView.secondColor = UIColor(red: 0.1, green: 0.8, blue: 0.67, alpha: 1)
//        backgroundGradientView.isHidden = true
        self.view.addSubview(backgroundGradientView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
