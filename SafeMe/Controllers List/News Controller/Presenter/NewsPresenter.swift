//
//  NewsPresenter.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

protocol NewsPresenterProtocol {
    func reloadData(news: [News], totalPages: Int)
}

typealias NewsPresenterDelegate = NewsPresenterProtocol & NewsViewController

class NewsPresenter {
    weak var delegate: NewsPresenterDelegate?
    
    func getNews(page: Int, size: Int = 10) {
        Network.shared.getNews(page: page, size: size) { [weak self] statusCode, news, totalPages in
            self?.delegate?.indicatorView.stopAnimating()
            guard let news = news else {
//                self?.pushAlert(statusCode)
                self?.reloadNews([], totalPages: totalPages ?? 1)
                return
            }
            self?.reloadNews(news, totalPages: totalPages ?? 1)
        }
    }
    
    
}

extension NewsPresenter {
    //MARK: Input
    
    //MARK: Output
    private func reloadNews(_ news: [News], totalPages: Int) {
        DispatchQueue.main.async {
            self.delegate?.reloadData(news: news, totalPages: totalPages)
        }
    }
    
    private func pushAlert(_ error:StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.alert(error: error, action: nil)
        }

    }
}
