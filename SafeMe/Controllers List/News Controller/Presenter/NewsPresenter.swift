//
//  NewsPresenter.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

protocol NewsPresenterProtocol {
    func reloadData(news: [News])
}

typealias NewsPresenterDelegate = NewsPresenterProtocol & NewsViewController

class NewsPresenter {
    weak var delegate: NewsPresenterDelegate?
    
    func getNews() {
        Network.shared.getNews() { [weak self] statusCode, news in
            let text = statusCode.message ?? "Not found"
            self?.delegate?.indicatorView.stopAnimating()
            guard let news = news else {
                self?.pushAlert(statusCode)
                return
            }
            self?.reloadNews(news)
        }
    }
    
    
}

extension NewsPresenter {
    //MARK: Input
    
    //MARK: Output
    private func reloadNews(_ news: [News]) {
        DispatchQueue.main.async {
            self.delegate?.reloadData(news: news)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }

    }
}
