//
//  AddChildViewController.swift
//  SafeMe
//
//  Created by Temur on 21/08/2023.
//

import UIKit
import SideMenu
class AddChildViewController: GradientViewController {
    private let bgView = UIView(.white)
    private let titleLabel = UILabel(text: "Add information about your child".localizedString, font: .robotoFont(ofSize: 20, weight: .medium))
    private let childNameLabel = UICustomTextField(title: "Child's name".localizedString, star: false, text: nil, placeholder: "Enter your child's name".localizedString)
    private let birthdayTextField = UICustomTextField(title: "Birthday".localizedString, star: false, text: nil, placeholder: nil)
    private let relationTextField = UICustomTextField(title: "Your relation to the child".localizedString, star: false, text: nil, placeholder: nil, type: .button)
    private let genderTextField = UICustomTextField(title: "Gender".localizedString, star: false, text: nil, placeholder: nil, type: .button)
    private let addChildButton = UIButton(.clear, radius: 12)
    private let nextButton = UIButton(.custom.buttonBackgroundColor, radius: 12)
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView(.clear)
    
    let datePicker = UIDatePicker()
    
    private let presenter = ChildViewPresenter()
    
    var child: Child?
    var childEdit: Child = Child(name: "", gender: "", date_birthday: "", type_parent: "")
    
    init(child: Child?) {
        self.child = child
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }
    
    private func initialize() {
        let contentView = UIView(.clear)
        let stackContainer = UIView(.clear)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, contentView, addChildButton, nextButton])
        SetupViews.addViewEndRemoveAutoresizingMask(superView: scrollView, array: [childNameLabel, birthdayTextField, relationTextField])
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: scrollView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: scrollView, view: stackContainer)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: stackContainer, view: stackView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: birthdayTextField, view: datePicker)
        
        [childNameLabel, birthdayTextField, relationTextField, genderTextField].forEach { view in
            self.stackView.addArrangedSubview(view)
        }
        
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: AuthApp.shared.language)
        datePicker.addTarget(self, action: #selector(changedDate(_:)), for: .valueChanged)
        
        bgView.layer.cornerRadius = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        addChildButton.addTarget(self, action: #selector(addChildAction), for: .touchUpInside)
        addChildButton.layer.borderColor = UIColor.custom.buttonGreenBgColor.cgColor
        addChildButton.layer.borderWidth = 1
        addChildButton.setTitleColor(.custom.buttonGreenBgColor, for: .normal)
        addChildButton.setTitle("Add child".localizedString, for: .normal)
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("Next".localizedString, for: .normal)
        
        let actionFather = UIAction(title: "Father".localizedString) { [weak self] _ in
            guard let self else { return }
            self.relationTextField.text = "Father".localizedString
            self.childEdit.type_parent = "ota"
        }
        let actionMother = UIAction(title: "Mother".localizedString) { [weak self] _ in
            guard let self else { return }
            self.relationTextField.text = "Mother".localizedString
            self.childEdit.type_parent = "ona"
        }
        let menu = UIMenu(title: "Choose relation".localizedString, children: [actionFather, actionMother])
        relationTextField.button.menu = menu
        
        let actionBoy = UIAction(title: "Boy".localizedString) { [weak self] _ in
            guard let self else { return }
            self.genderTextField.text = "Boy".localizedString
            self.childEdit.gender = "erkak"
        }
        let actionGirl = UIAction(title: "Girl".localizedString) { [weak self] _ in
            guard let self else { return }
            self.genderTextField.text = "Girl".localizedString
            self.childEdit.gender = "ayol"
        }
        let menuGender = UIMenu(title: "Choose gender".localizedString, children: [actionBoy, actionGirl])
        self.genderTextField.button.menu = menuGender
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            
            addChildButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -8),
            addChildButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            addChildButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            addChildButton.heightAnchor.constraint(equalToConstant: 40),
            
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            contentView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: addChildButton.topAnchor, constant: -16),
            
            
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            
            stackContainer.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            stackContainer.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            stackContainer.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            stackContainer.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            
            
            stackView.leadingAnchor.constraint(equalTo: stackContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stackContainer.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: stackContainer.bottomAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: stackContainer.topAnchor),
//            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            stackView.heightAnchor.constraint(greaterThanOrEqualTo: contentView.heightAnchor, multiplier: 1),
            
            datePicker.bottomAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: -4),
            datePicker.trailingAnchor.constraint(equalTo: birthdayTextField.trailingAnchor, constant: -8)
            
        ])
        
    }
    
    @objc private func changedDate(_ sender: UIDatePicker) {
        birthdayTextField.text = sender.date.toString("dd-MM-yyyy")
        childEdit.date_birthday = sender.date.toString("yyyy-MM-dd")
    }
    
    @objc private func addChildAction() {
        if childNameLabel.isEmpty || genderTextField.isEmpty || birthdayTextField.isEmpty || relationTextField.isEmpty {
            alert(title: "Fields are not filled".localizedString, message: "Please fill all fields".localizedString, url: nil)
        }else {
            presenter.addChild(name: childNameLabel.text, gender: childEdit.gender, date_birthday: childEdit.date_birthday, type_parent: childEdit.type_parent)
        }
    }
    
    @objc private func nextAction() {
        let vc = SuggestionsViewController()
        let sideController = SideMenuNavigationController(rootViewController: vc)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        let navController = sideController
        keyWindow?.rootViewController = navController
    }
}

extension AddChildViewController: ChildViewPresenterProtocol {
    func success(_ statusCode: StatusCode) {
        self.indicatorView.stopAnimating()
        let alert = UIAlertController(title: statusCode.title, message: statusCode.message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: String.localized.close, style: .cancel) { _ in
            let vc = SuggestionsViewController()
            let sideController = SideMenuNavigationController(rootViewController: vc)
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            let navController = sideController
            keyWindow?.rootViewController = navController
        }
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
