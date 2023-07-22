//
//  BaseViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit

class GradientViewController: UIViewController {
    let backgroundGradientView = GradientView()
    lazy var indicatorView:UIIndicatorView = UIIndicatorView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit { print(#function, Self.self)}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        backgroundGradientView.translatesAutoresizingMaskIntoConstraints = false
        backgroundGradientView.firstColor = UIColor(red: 0.1, green: 0.63, blue: 0.8, alpha: 1)
        backgroundGradientView.secondColor = UIColor(red: 0.1, green: 0.8, blue: 0.67, alpha: 1)
//        backgroundGradientView.isHidden = true
        self.view.addSubview(backgroundGradientView)
        
        view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.fullConstraint()
        indicatorView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func alert(title:String?, message:String?, url:URL?) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            let alerts = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: url == nil ? String.localized.close : String.localized.cancel, style: .cancel, handler: nil)
            alerts.addAction(cancel)
            
            if let url = url {
                let setting = UIAlertAction(title: "Settings".localizedString, style: .default) { (action) in
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                alerts.addAction(setting)
            }
            self.present(alerts, animated: true, completion: nil)
        }
    }
    
    func alert(error:StatusCode, action: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: String.localized.close, style: .cancel, handler: action)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
}
