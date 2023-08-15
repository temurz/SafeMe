//
//  UpdateProfileViewController.swift
//  SafeMe
//
//  Created by Temur on 09/08/2023.
//

import UIKit
class UpdateProfileViewController: GradientViewController {
    private let bgView = UIView(.white)
    private let titleLabel = UILabel(text: "Shaxsiy ma'lumotlaringizni kiriting".localizedString, font: .robotoFont(ofSize: 20, weight: .medium))
    private let stackView = UIStackView()
    private let fullNameTextField = UICustomTextField(title: "Fullname".localizedString, star: false, text: nil, placeholder: "Fullname".localizedString)
    private let birthdayTextField = UICustomTextField(title: "Birthday", star: false, text: nil, placeholder: "Enter your birthday".localizedString)
    private let educationTextField = UICustomTextField(title: "Education".localizedString, star: false, text: nil, placeholder: nil)
    private let regionButton = UICustomTextField(title: "Region".localizedString, star: false, text: nil, placeholder: nil, height: 60, type: .button)
    private let districtButton = UICustomTextField(title: "District".localizedString, star: false, text: nil, placeholder: nil, height: 60, type: .button)
    private let mahallaButton = UICustomTextField(title: "Mahalla".localizedString, star: false, text: nil, placeholder: nil, height: 60, type: .button)
    private let nextButton = UIButton(backgroundColor: UIColor.custom.buttonBackgroundColor,
                                      textColor: .custom.white,
                                      text: "Next".localizedString, radius: 8)
    
    private var user: User?
    private let presenter = UpdateProfilePresenter()
    
    init(user: User?) {
        self.user = user
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
        setupConstraints()
        presenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getRegions(page: 1, size: 10)
    }
    
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, stackView, nextButton])
        [fullNameTextField, birthdayTextField, educationTextField, regionButton, districtButton, mahallaButton].forEach { view in
            self.stackView.addArrangedSubview(view)
        }
        
        bgView.layer.cornerRadius = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor,constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 38),
        
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16)
            
        ])
    }
    
    @objc private func nextAction() {
        presenter
    }
}

extension UpdateProfileViewController: UpdateProfilePresenterProtocol {
    func updateRegions(regions: [Region]) {
        var actions = [UIAction]()
        regions.forEach { region in
            let action1 = UIAction(title: region.name ?? "", image: nil) { action in
                DispatchQueue.main.async {
                    self.regionButton.button.setTitle(region.name, for: .normal)
                }
            }
            actions.append(action1)
        }
        let action = UIAction(title: "region", image: nil) { action in
            self.regionButton.button.setTitle("region", for: .normal)
        }
        actions.append(action)
        let menu = UIMenu(title: "Choose region".localizedString, children: actions)
        regionButton.button.menu = menu
    }
    
    func updateDistricts(districts: [District]) {
        var actions = [UIAction]()
        districts.forEach { district in
            let action1 = UIAction(title: district.name ?? "", image: nil) { action in
                DispatchQueue.main.async {
                    self.regionButton.button.setTitle(district.name, for: .normal)
                }
            }
            actions.append(action1)
        }
        let action = UIAction(title: "district", image: nil) { action in
            self.regionButton.button.setTitle("district", for: .normal)
        }
        actions.append(action)
        let menu = UIMenu(title: "Choose district".localizedString, children: actions)
        districtButton.button.menu = menu
    }
    
    func updateMahallas(mahallas: [Mahalla]) {
        var actions = [UIAction]()
        mahallas.forEach { mahalla in
            let action1 = UIAction(title: mahalla.name ?? "", image: nil) { action in
                DispatchQueue.main.async {
                    self.regionButton.button.setTitle(mahalla.name, for: .normal)
                }
            }
            actions.append(action1)
        }
        let action = UIAction(title: "mahalla", image: nil) { action in
            self.regionButton.button.setTitle("mahalla", for: .normal)
        }
        actions.append(action)
        let menu = UIMenu(title: "Choose mahalla".localizedString, children: actions)
        mahallaButton.button.menu = menu
    }
}
