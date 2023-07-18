//
//  SetupViews.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit
//Singleton
class SetupViews {
    private init() {}
    static var shared = SetupViews()
    
    static func addViewEndRemoveAutoresizingMask(superView:UIView, array views: [UIView]) {
        for row in 0...views.count - 1 {
            superView.addSubview(views[row])
            views[row].translatesAutoresizingMaskIntoConstraints = false
        }
    }
    static func addViewEndRemoveAutoresizingMask(superView:UIView,  view: UIView) {
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
