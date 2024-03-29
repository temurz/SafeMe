//
//  NewsDetailViewController.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import UIKit
import WebKit

class NewsDetailViewController: GradientViewController {
    private let scrollView = UIScrollView()
    private let mainImageView = UIImageView()
    private let titleLabel = UILabel()
    private let webView = WKWebView()
    private let dateView = UIButton(.custom.dateBackgroundColor)
    private let eyeView = UIButton(.custom.dateBackgroundColor)
    let news: News
    
    init(news: News) {
        self.news = news
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
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: scrollView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: scrollView, array: [mainImageView, titleLabel, webView, dateView, eyeView])
        
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 12
//        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollView.contentOffset.y)
        
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
        
        
        mainImageView.sd_setImage(with: URL(string: news.image ?? ""))
        mainImageView.layer.cornerRadius = 12
        mainImageView.layer.masksToBounds = true
        
        titleLabel.text = news.title
        titleLabel.font = .robotoFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        webView.loadHTMLString(headerString + (news.content ?? ""), baseURL: nil)
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
//        webView.scrollView.minimumZoomScale = 1.0
//        webView.scrollView.maximumZoomScale = 150 // You can adjust this value to control the maximum zoom level
//        webView.scrollView.zoomScale = 150
        
        dateView.setImage(UIImage(named: "calendar"), for: .normal)
        dateView.setTitle(news.created_date?.convertToDateUS(), for: .normal)
        dateView.setTitleColor(.custom.grayDate, for: .normal)
        dateView.titleLabel?.font = .robotoFont(ofSize: 13, weight: .medium)
        dateView.leftImage()
        dateView.layer.cornerRadius = 5
        dateView.isUserInteractionEnabled = false
        
        eyeView.isUserInteractionEnabled = false
        eyeView.setImage(UIImage(named: "visibility"), for: .normal)
        eyeView.setTitle("\(news.views ?? 0)", for: .normal)
        eyeView.setTitleColor(.custom.grayDate, for: .normal)
        eyeView.titleLabel?.font = .robotoFont(ofSize: 13, weight: .medium)
        eyeView.leftImage(left: 10, right: 10)
        eyeView.layer.cornerRadius = 5
        
    }
    
    private func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            mainImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            mainImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.82),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1),
            
            webView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            webView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            webView.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1),
            
            dateView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            dateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            dateView.widthAnchor.constraint(equalToConstant: 100),
            dateView.heightAnchor.constraint(equalToConstant: 30),
            
            eyeView.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: 12),
            eyeView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            eyeView.widthAnchor.constraint(equalToConstant: 60),
            eyeView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
}


extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                if complete != nil {
                    webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                        if let height = height as? CGFloat {
                            // Update the height constraint of the web view
                            let minHeight: CGFloat = 50
                            
                            let newHeight = max(minHeight, height)
                            self.webView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
                            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width - 32, height: newHeight +  UIScreen.main.bounds.width * 1.1 + (self.titleLabel.text?.height(withConstrainedWidth: self.view.frame.width, font: self.titleLabel.font) ?? 50))
                        }
                    })
                }
            })
    }
}
