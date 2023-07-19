//
//  MainViewController.swift
//  SafeMe
//
//  Created by Temur on 18/07/2023.
//

import UIKit
import SideMenu
class BaseViewController: GradientViewController {
    let button = UIButton(backgroundColor: .clear, textColor: .blue, text: "Left menu")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navController = self.navigationController as! SideMenuNavigationController
        navController.leftSide = true
        navController.navigationBar.backgroundColor = .clear
        button.addTarget(self, action: #selector(leftSideMenuAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc public func leftSideMenuAction(_ sender: UIButton) {
        let vc = SideMenuViewController(currentRow: sender.tag)
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        var menuSettings = SideMenuSettings()
        menuSettings.presentationStyle = .menuSlideIn
        menuSettings.menuWidth = self.view.frame.width * 0.84
        menu.settings = menuSettings
        menu.pushStyle = .replace
        menu.allowPushOfSameClassTwice = false
        vc.selectedRowAction = { id in
            switch id {
            case 0:
                menu.pushViewController(ViewController(), animated: true)
            case 1:
                menu.pushViewController(NewsViewController(), animated: true)
            case 2:
                menu.pushViewController(ChatViewController(), animated: true)
            case 3:
                menu.pushViewController(ConsultantViewController(), animated: true)
            case 4:
                menu.pushViewController(PollViewController(), animated: true)
            case 5:
                menu.pushViewController(InspectorsViewController(), animated: true)
            case 6:
                menu.pushViewController(ApplicationsViewController(), animated: true)
            case 7:
                menu.pushViewController(AboutViewController(), animated: true)
            case 8:
                break
            default:
                break
            }
        }
        present(menu, animated: true, completion: nil)
    }
}
