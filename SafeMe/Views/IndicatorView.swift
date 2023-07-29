//
//  IndicatorView.swift
//  SafeMe
//
//  Created by Temur on 23/07/2023.
//

import Foundation
import UIKit

class UIIndicatorView: UIView {
    enum InfoText {
        case download
        case update
        case pushData
        case auth
        
        
        var string: String {
            switch self {
                
            case .download:
                return "Uploading data...".localizedString
            case .update:
                return String.localized.update
            case .pushData:
                return "Sending data...".localizedString
            case .auth:
                return "Authorization...".localizedString
            }
        }
    }

    private let view:UIView
    private let indicator:UIActivityIndicatorView
    private let label:UILabel
    var text:String? = "" {
        willSet {
            label.text = newValue
        }
    }
    
    override init(frame:CGRect) {
        view = UIView(.custom.black)
        view.alpha = 0.1
        indicator = UIActivityIndicatorView()
        label = UILabel(text: "", ofSize: 13, weight: .medium, color: .systemGray)
        super.init(frame: frame)
        setapView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    private func setapView() {
        label.backgroundColor = .clear
        label.contentMode = .center
        label.textAlignment = .center
        indicator.style = .large
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = .clear
        indicator.stopAnimating()
        SetupViews.addViewEndRemoveAutoresizingMask(superView: self, array: [view, indicator, label])
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            indicator.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -5),
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.heightAnchor.constraint(equalTo: indicator.widthAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 50),
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

        ])
        stopAnimating()
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.isHidden = true
            self.indicator.stopAnimating()
            self.text = ""
        }
    }
    
    func startAnimating(_ info:InfoText! = .download) {
        self.text = info.string
        indicator.startAnimating()
        self.isHidden = false
    }

}
