//
//  ViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit
import SideMenu

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .custom.mainBackgroundColor
        self.title = "Title"
        let navController = self.navigationController as! SideMenuNavigationController
        navController.leftSide = true
        navController.navigationBar.backgroundColor = .clear
        let button = UIButton(backgroundColor: .clear, textColor: .blue, text: "Left menu")
        button.addTarget(self, action: #selector(leftSideMenuAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    
    
    @objc private func leftSideMenuAction() {
        let menu = SideMenuNavigationController(rootViewController: TestViewController())
        menu.leftSide = true
        var menuSettings = SideMenuSettings()
        menuSettings.presentationStyle = .menuSlideIn
        menuSettings.menuWidth = self.view.frame.width * 0.84
        menu.settings = menuSettings
        present(menu, animated: true, completion: nil)
    }
}

