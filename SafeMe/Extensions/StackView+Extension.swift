//
//  StackView+Extension.swift
//  SafeMe
//
//  Created by Temur on 15/07/2023.
//

import UIKit

extension UIStackView {
    
    convenience init(_ axis: NSLayoutConstraint.Axis,
                           _ distribution:UIStackView.Distribution,
                           _ alignment: UIStackView.Alignment,
                           _ spacing: CGFloat,
                           _ arrangedSubviews: [UIView] ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.backgroundColor = .clear
    }
}
