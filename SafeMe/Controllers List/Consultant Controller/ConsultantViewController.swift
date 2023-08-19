//
//  ConsultantViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class ConsultantViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "Konsultant".localizedString
        leftMenuButton.tag = 3
    }
}
