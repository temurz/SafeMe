//
//  ViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit
import SideMenu

class SuggestionsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .custom.mainBackgroundColor
//        self.title = "Tavsiyalar"
        navBarTitleLabel.text = "Tavsiyalar"
        leftMenuButton.tag = 0
    }
    
    
}

