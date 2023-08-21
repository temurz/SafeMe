//
//  ChangePasswordViewController.swift
//  SafeMe
//
//  Created by Temur on 21/08/2023.
//

import UIKit
class ChangePasswordViewController: GradientViewController {
    
    private var phoneNumber: String
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
