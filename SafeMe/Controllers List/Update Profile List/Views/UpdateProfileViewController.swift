//
//  UpdateProfileViewController.swift
//  SafeMe
//
//  Created by Temur on 09/08/2023.
//

import UIKit
import SideMenu
class UpdateProfileViewController: GradientViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    private let bgView = UIView(.white)
    private let titleLabel = UILabel(text: "Enter your personal data".localizedString, font: .robotoFont(ofSize: 20, weight: .medium))
    let choosePhotoLabel = UILabel(text: "Choose a photo".localizedString, font: .robotoFont(ofSize: 14))
    private let profilePhotoImageView = UIImageView(.custom.lightGray)
    private let stackView = UIStackView()
    private let fullNameTextField = UICustomTextField(title: "Fullname".localizedString, star: false, text: nil, placeholder: "Fullname".localizedString)
    private let birthdayTextField = UICustomTextField(title: "Birthday".localizedString, star: false, text: nil, placeholder: nil)
    private let genderTextField = UICustomTextField(title: "Gender".localizedString, star: false, text: nil, placeholder: nil, type: .button)
    private let regionButton = UICustomTextField(title: "Region".localizedString, star: false, text: nil, placeholder: nil, height: 32, type: .button)
    private let districtButton = UICustomTextField(title: "District".localizedString, star: false, text: nil, placeholder: nil, height: 32, type: .button)
    private let mahallaButton = UICustomTextField(title: "Mahalla".localizedString, star: false, text: nil, placeholder: nil, height: 32, type: .button)
    private let nextButton = UIButton(backgroundColor: UIColor.custom.buttonBackgroundColor,
                                      textColor: .custom.white,
                                      text: "Next".localizedString, radius: 8)
    private let imagePicker = UIImagePickerController()
    private lazy var scrollView = UIScrollView()
    
    let datePicker = UIDatePicker()
    
    private var user: User?
    private var withNavigation: Bool
    private var userEdit = UserEdit(fullName: "", birthday: "")
    private let presenter = UpdateProfilePresenter()
    
    init(user: User?, withNavigation: Bool) {
        self.user = user
        self.withNavigation = withNavigation
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
        if let _ = user?.region {
            presenter.getDistricts(region: 0, page: 1, size: 10)
        }
        if let _ = user?.district {
            presenter.getMahallas(region: 0, district: 0, page: 1, size: 10)
        }
    }
    
    
    private func initialize() {
        let contentView = UIView(.clear)
        let photoView = UIView(.clear)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: photoView, view: profilePhotoImageView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: bgView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgView, array: [titleLabel, contentView, nextButton])
        SetupViews.addViewEndRemoveAutoresizingMask(superView: scrollView, array: [stackView])
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, view: scrollView)
        
        [photoView, fullNameTextField, birthdayTextField, genderTextField, regionButton, districtButton, mahallaButton].forEach { view in
            self.stackView.addArrangedSubview(view)
        }
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: birthdayTextField, view: datePicker)
        
        profilePhotoImageView.contentMode = .scaleAspectFill
        profilePhotoImageView.clipsToBounds = true
        profilePhotoImageView.layer.cornerRadius = 8
        
        titleLabel.numberOfLines = 0
        
        choosePhotoLabel.isUserInteractionEnabled = false
        choosePhotoLabel.numberOfLines = 2
        choosePhotoLabel.textColor = .custom.blue
        choosePhotoLabel.textAlignment = .center
        profilePhotoImageView.addSubview(choosePhotoLabel)
        choosePhotoLabel.fullConstraint(leading: 8, trailing: -8)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(choosePhotoAction(_:)))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        profilePhotoImageView.isUserInteractionEnabled = true
        profilePhotoImageView.addGestureRecognizer(tap)
        
        imagePicker.delegate = self
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: AuthApp.shared.language)
        datePicker.addTarget(self, action: #selector(changedDate(_:)), for: .valueChanged)
        
        bgView.layer.cornerRadius = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        if let user = user {
            fullNameTextField.text = user.last_name + " " + user.first_name
            birthdayTextField.text = user.birth_day ?? ""
            genderTextField.text = user.gender ?? ""
            regionButton.button.setTitle(user.region ?? "", for: .normal)
            districtButton.button.setTitle(user.district ?? "", for: .normal)
            mahallaButton.button.setTitle(user.mahalla ?? "", for: .normal)
            profilePhotoImageView.sd_setImage(with: URL(string: user.photo ?? ""))
        }
        
        choosePhotoLabel.isHidden = profilePhotoImageView.image != nil ? true : false
        
        let actionBoy = UIAction(title: "Man".localizedString) { [weak self] _ in
            guard let self else { return }
            self.genderTextField.text = "Man".localizedString
        }
        let actionGirl = UIAction(title: "Woman".localizedString) { [weak self] _ in
            guard let self else { return }
            self.genderTextField.text = "Woman".localizedString
        }
        let menuGender = UIMenu(title: "Choose gender".localizedString, children: [actionBoy, actionGirl])
        self.genderTextField.button.menu = menuGender
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 96),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 96),
            profilePhotoImageView.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            profilePhotoImageView.topAnchor.constraint(equalTo: photoView.topAnchor),
            profilePhotoImageView.bottomAnchor.constraint(equalTo: photoView.bottomAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor,constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 38),
            
            
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.heightAnchor.constraint(greaterThanOrEqualTo: contentView.heightAnchor, multiplier: 1),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            
            datePicker.bottomAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: -4),
            datePicker.trailingAnchor.constraint(equalTo: birthdayTextField.trailingAnchor, constant: -8)
            
        ])
    }
    
    private func setupConstraints() {
        
    }
    
    @objc private func nextAction() {
        presenter.sendUserData(fullName: fullNameTextField.text, birthday: userEdit.birthday, region: userEdit.region, district: userEdit.district, mahalla: userEdit.mahalla, photo: userEdit.photo)
    }
    
    @objc private func changedDate(_ sender: UIDatePicker) {
        birthdayTextField.text = sender.date.toString("dd-MM-yyyy")
        self.userEdit.birthday = sender.date.toString("yyyy-MM-dd")
        datePicker.endEditing(true)
    }
    
    @objc private func choosePhotoAction(_ sender: UIGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "Select source".localizedString, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera".localizedString, style: .default) { (result : UIAlertAction) -> Void in
            print("Camera selected")
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Gallery".localizedString, style: .default) { (result : UIAlertAction) -> Void in
            print("Photo selected")
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let cancel = UIAlertAction(title: "Cancel".localizedString, style: .cancel)
        
        alert.addAction(cancel)
        
        if let popOver = alert.popoverPresentationController {
            popOver.sourceView = self.view
            popOver.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popOver.permittedArrowDirections = []
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UpdateProfileViewController: UpdateProfilePresenterProtocol {
    func updateUser() {
        if withNavigation {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let vc = SuggestionsViewController()
        let sideController = SideMenuNavigationController(rootViewController: vc)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController = sideController
    }
    
    func updateRegions(regions: [Region]) {
        if let user = user {
            for region in regions {
                if region.name == user.region {
                    self.userEdit.region = region.id
                    presenter.getDistricts(region: region.id, page: 1, size: 10)
                }
            }
        }
        var actions = [UIAction]()
        regions.forEach { region in
            let action1 = UIAction(title: region.name ?? "", image: nil) { action in
                self.userEdit.region = region.id
                DispatchQueue.main.async {
                    self.regionButton.button.setTitle(region.name, for: .normal)
                    self.presenter.getDistricts(region: region.id, page: 1, size: 14)
                }
            }
            actions.append(action1)
        }
        let menu = UIMenu(title: "Choose region".localizedString, children: actions)
        regionButton.button.menu = menu
    }
    
    func updateDistricts(districts: [District]) {
        if let user = user {
            for district in districts {
                if district.name == user.district {
                    self.userEdit.district = district.id
                    presenter.getMahallas(region: userEdit.region ?? 1, district: district.id, page: 1, size: 10)
                }
            }
        }
        var actions = [UIAction]()
        districts.filter({$0.region == self.userEdit.region}).forEach { district in
            let action1 = UIAction(title: district.name ?? "", image: nil) { action in
                self.userEdit.district = district.id
                DispatchQueue.main.async {
                    self.districtButton.button.setTitle(district.name, for: .normal)
                    self.presenter.getMahallas(region: self.userEdit.region ?? 1, district: district.id, page: 1, size: 10)
                }
            }
            actions.append(action1)
        }
        let menu = UIMenu(title: "Choose district".localizedString, children: actions)
        districtButton.button.menu = menu
    }
    
    func updateMahallas(mahallas: [Mahalla]) {
        if let user = user {
            for mahalla in mahallas {
                if mahalla.name == user.mahalla {
                    self.userEdit.mahalla = mahalla.id
                }
            }
        }
        var actions = [UIAction]()
        mahallas.filter({$0.district == self.userEdit.district && $0.region == self.userEdit.region}).forEach { mahalla in
            let action1 = UIAction(title: mahalla.name ?? "", image: nil) { action in
                self.userEdit.mahalla = mahalla.id
                DispatchQueue.main.async {
                    self.mahallaButton.button.setTitle(mahalla.name, for: .normal)
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

extension UpdateProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePhotoImageView.image = pickedImage
            userEdit.photo = pickedImage.sd_imageData()
            imagePicker.dismiss(animated: true)
            choosePhotoLabel.isHidden = true
//            enableButton()
        }
    }
}
