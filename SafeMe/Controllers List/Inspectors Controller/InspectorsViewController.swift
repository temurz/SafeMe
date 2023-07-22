//
//  InspectorsViewController.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class InspectorsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarTitleLabel.text = "Inspektorlar"
        leftMenuButton.tag = 5
    }
}
