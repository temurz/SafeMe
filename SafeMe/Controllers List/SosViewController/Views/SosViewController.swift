//
//  SosViewController.swift
//  SafeMe
//
//  Created by Temur on 27/07/2023.
//

import UIKit
import CoreLocation
enum SOSType: String {
    case suspicious = "shubhali"
    case dangerZone = "xavli_hudud"
    case help = "danger"
}
class SosViewController: GradientViewController {
    
    private let firstCallButton = UIButton()
    private let secondCallButton = UIButton()
    private let thirdCallButton = UIButton()
    private let sosLabel = UILabel()
    
    var locationManager = CLLocationManager()
    private var sosType = SOSType.dangerZone
    
    private var presenter = SosViewPresenter()
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SOS"
        setupConstraints()
        presenter.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [firstCallButton, secondCallButton, thirdCallButton, sosLabel ])
        
        sosLabel.textColor = .white
        sosLabel.backgroundColor = .clear
        sosLabel.text = "SOS"
        sosLabel.font = .systemFont(ofSize: 72, weight: .medium)
        
        firstCallButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#FFC600")
        firstCallButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        firstCallButton.setTitle("There are suspicious circumstances".localizedString, for: .normal)
        firstCallButton.addTarget(self, action: #selector(firstCallButtonAction), for: .touchUpInside)
        firstCallButton.layer.cornerRadius = 12
        firstCallButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#6F2B15"), for: .normal)
        firstCallButton.layer.shadowColor = UIColor.gray.cgColor
        firstCallButton.layer.masksToBounds = true
        firstCallButton.clipsToBounds = false
        firstCallButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        firstCallButton.layer.shadowRadius = 7
        firstCallButton.layer.shadowOpacity = 0.5
        
        secondCallButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#FFA607")
        secondCallButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        secondCallButton.setTitle("Going into danger zone".localizedString, for: .normal)
        secondCallButton.layer.cornerRadius = 12
        secondCallButton.addTarget(self, action: #selector(secondCallButtonAction), for: .touchUpInside)
        secondCallButton.setTitleColor(UIColor.hexStringToUIColor(hex: "#7A4E00"), for: .normal)
        secondCallButton.layer.shadowColor = UIColor.gray.cgColor
        secondCallButton.layer.masksToBounds = true
        secondCallButton.clipsToBounds = false
        secondCallButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        secondCallButton.layer.shadowRadius = 7
        secondCallButton.layer.shadowOpacity = 0.5
        
        thirdCallButton.backgroundColor = UIColor.hexStringToUIColor(hex: "#E15C2F")
        thirdCallButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        thirdCallButton.setTitle("Help needed now".localizedString, for: .normal)
        thirdCallButton.layer.cornerRadius = 12
        thirdCallButton.addTarget(self, action: #selector(thirdCallButtonAction), for:
                .touchUpInside)
        thirdCallButton.layer.shadowColor = UIColor.gray.cgColor
        thirdCallButton.layer.masksToBounds = true
        thirdCallButton.clipsToBounds = false
        thirdCallButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        thirdCallButton.layer.shadowRadius = 7
        thirdCallButton.layer.shadowOpacity = 0.5
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            sosLabel.bottomAnchor.constraint(equalTo: firstCallButton.topAnchor, constant: -140),
            sosLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstCallButton.bottomAnchor.constraint(equalTo: secondCallButton.topAnchor, constant: -24),
            firstCallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstCallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstCallButton.heightAnchor.constraint(equalTo: firstCallButton.widthAnchor, multiplier: 0.17),
            
            secondCallButton.bottomAnchor.constraint(equalTo: thirdCallButton.topAnchor, constant: -24),
            secondCallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondCallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondCallButton.heightAnchor.constraint(equalTo: secondCallButton.widthAnchor, multiplier: 0.17),
            
            thirdCallButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            thirdCallButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            thirdCallButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            thirdCallButton.heightAnchor.constraint(equalTo: thirdCallButton.widthAnchor, multiplier: 0.35),
            
        ])
    }
    
    @objc private func firstCallButtonAction() {
        sosType = .suspicious
        locationManager.requestLocation()
    }
    
    @objc private func secondCallButtonAction() {
        sosType = .dangerZone
        locationManager.requestLocation()
    }
    
    @objc private func thirdCallButtonAction() {
        sosType = .help
        locationManager.requestLocation()
    }
}

extension SosViewController: CLLocationManagerDelegate, SosViewPresenterProtocol {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.last {
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            presenter.sendSosSignal(long: longitude, lat: latitude, type: sosType.rawValue)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
