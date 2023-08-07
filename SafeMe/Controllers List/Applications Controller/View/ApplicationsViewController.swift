//
//  File.swift
//  SafeMe
//
//  Created by Temur on 19/07/2023.
//

import UIKit

class ApplicationsViewController: BaseViewController, UITextViewDelegate {
        
    private let contextMenuView = UIView()
    
    private let bgView = UIView(.white)
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    
    private let firstButton = UIButton()
    private let firstTextField = UITextView()
    private let sendButton = UIButton()
    
    private var secondTextField = UITextView()
    
    private let arrowImage = UIImageView()
    
    private let presenter = ApplicationsViewPresenter()
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        secondTextField.delegate = self
        navBarTitleLabel.text = "Murojaatlar"
        leftMenuButton.tag = 6
        setupConstraints()
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [bgView, firstLabel, secondLabel, thirdLabel, firstButton, firstTextField, secondTextField, arrowImage, sendButton, ])
        
        bgView.layer.cornerRadius = 12
        
        firstTextField.font = .systemFont(ofSize: 16)
        firstTextField.autocapitalizationType = .words
        firstTextField.layer.cornerRadius = 6
        firstTextField.layer.borderWidth = 1
        firstTextField.backgroundColor = .clear
        firstTextField.layer.borderColor = UIColor.hexStringToUIColor(hex: "#E6EAF0").cgColor
        firstTextField.delegate = self
        firstTextField.isEditable = true
        
        secondTextField.font = .systemFont(ofSize: 16)
        secondTextField.autocapitalizationType = .words
        secondTextField.delegate = self
        secondTextField.isEditable = true
        secondTextField.layer.cornerRadius = 6
        secondTextField.layer.borderWidth = 1
        secondTextField.backgroundColor = .clear
        secondTextField.layer.borderColor = UIColor.hexStringToUIColor(hex: "#E6EAF0").cgColor
        secondTextField.textColor = .black
        
        firstLabel.text = "Murojaat turini tanlang"
        firstLabel.textColor = .systemGray
        firstLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        secondLabel.text = "Murojaat mavzusini kiriting"
        secondLabel.textColor = .systemGray
        secondLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        thirdLabel.text = "Murojaat matnini kiriting"
        thirdLabel.textColor = .systemGray
        thirdLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        let action1 = UIAction(title: "Ariza".localizedString, image: UIImage(named: "action1")) { action in
            DispatchQueue.main.async {
                self.firstButton.setTitle("Ariza".localizedString, for: .normal)
            }
        }
        
        let action2 = UIAction(title: "Shikoyat".localizedString, image: UIImage(named: "action2")) { action in
            DispatchQueue.main.async {
                self.firstButton.setTitle("Shikoyat".localizedString, for: .normal)
            }
        }
        
        let action3 = UIAction(title: "Taklif".localizedString, image: UIImage(named: "action3")) { action in
            DispatchQueue.main.async {
                self.firstButton.setTitle("Taklif".localizedString, for: .normal)
            }
        }
        
        let menu = UIMenu(title: "Murojaat turlari".localizedString, children: [action1, action2, action3])
        
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.menu = menu
        firstButton.showsMenuAsPrimaryAction = true
        firstButton.layer.cornerRadius = 6
        firstButton.layer.borderWidth = 1
        firstButton.backgroundColor = .clear
        firstButton.layer.borderColor = UIColor.hexStringToUIColor(hex: "#E6EAF0").cgColor
        firstButton.contentHorizontalAlignment = .left
        firstButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        sendButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#6BBDF6")
        sendButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        sendButton.setTitle("Yuborish", for: .normal)
        sendButton.layer.cornerRadius = 8
        sendButton.addTarget(self, action: #selector(thirdButtonAction), for: .touchUpInside)
        sendButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        sendButton.layer.shadowColor = UIColor.gray.cgColor
        sendButton.layer.masksToBounds = true
        sendButton.clipsToBounds = false
        sendButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        sendButton.layer.shadowRadius = 7
        sendButton.layer.shadowOpacity = 0.5
        
        
        arrowImage.image = UIImage(named: "downArrow")
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.clipsToBounds = true
        self.view.addSubview(arrowImage)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            bgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalTo: bgView.widthAnchor, multiplier: 1.26),
            
            firstLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            firstLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            firstLabel.heightAnchor.constraint(equalTo: firstLabel.widthAnchor, multiplier: 0.11),
            
            firstButton.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 8),
            firstButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            firstButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            firstButton.heightAnchor.constraint(equalTo: firstButton.widthAnchor, multiplier: 0.16),
            
            arrowImage.topAnchor.constraint(equalTo: firstButton.topAnchor, constant: 12),
            arrowImage.trailingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: -12),
            arrowImage.bottomAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: -12),
            arrowImage.heightAnchor.constraint(equalTo: arrowImage.widthAnchor, multiplier: 1),
            
            secondLabel.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),
            secondLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            secondLabel.heightAnchor.constraint(equalTo: secondLabel.widthAnchor, multiplier: 0.11),
            
            firstTextField.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 8),
            firstTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            firstTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            firstTextField.heightAnchor.constraint(equalTo: firstTextField.widthAnchor, multiplier: 0.16),
            
            thirdLabel.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20),
            thirdLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            thirdLabel.heightAnchor.constraint(equalTo: thirdLabel.widthAnchor, multiplier: 0.11),
            
            secondTextField.topAnchor.constraint(equalTo: thirdLabel.bottomAnchor, constant: 8),
            secondTextField.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            secondTextField.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            secondTextField.heightAnchor.constraint(equalTo: secondTextField.widthAnchor, multiplier: 0.33),
            
            sendButton.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 28),
            sendButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            sendButton.heightAnchor.constraint(equalTo: sendButton.widthAnchor, multiplier: 0.12),
            
            
        ])
    }
    
//    private func textViewDidBeginEditing (textView: UITextView) {
//        if secondTextField.textColor.textColor == ph_TextColor && secondTextField.isFirstResponder() {
//            secondTextField.text = nil
//            secondTextField.textColor = .white
//        }
//    }
    
    private func textViewDidEndEditing (textView: UITextView) {
        if secondTextField.text.isEmpty || secondTextField.text == "" {
            secondTextField.textColor = .lightGray
            secondTextField.text = "Type your thoughts here..."
        }
    }
    
    
    @objc private func thirdButtonAction() {
        presenter.sendComplaint(type: firstButton.titleLabel?.text ?? "", title: firstTextField.text, text: secondTextField.text)
    }
}

extension ApplicationsViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in

            let action1 = UIAction(title: "Ariza".localizedString, image: UIImage(named: "action1")) { action in
                DispatchQueue.main.async {
                    self.firstButton.setTitle("Ariza".localizedString, for: .normal)
                }
            }
            
            let action2 = UIAction(title: "Shikoyat".localizedString, image: UIImage(named: "action2")) { action in
                DispatchQueue.main.async {
                    self.firstButton.setTitle("Shikoyat".localizedString, for: .normal)
                }
            }
            
            let action3 = UIAction(title: "Taklif".localizedString, image: UIImage(named: "action3")) { action in
                DispatchQueue.main.async {
                    self.firstButton.setTitle("Taklif".localizedString, for: .normal)
                }
            }
            
            return UIMenu(title: "Murojaat turlari".localizedString, children: [action1, action2, action3])
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        animator?.addAnimations {
            
            UIView.setAnimationsEnabled(true)
        }
    }
    
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//        animator.addAnimations {
//
//            UIView.setAnimationsEnabled(false)
//        }
//
//    }
}

extension ApplicationsViewController: ApplicationsViewPresenterProtocol {
    
}
