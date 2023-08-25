//
//  PollViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 18/08/2023.
//

import Foundation

protocol PollViewPresenterProtocol {
    func updatePolls(_ polls: [PollingModel], totalPages: Int)
    func reloadAgeCategories(_ ageCategories: [AgeCategory])
}

typealias PollViewPresenterDelegate = PollViewPresenterProtocol & PollViewController

class PollViewPresenter {
    weak var delegate: PollViewPresenterDelegate?
    
    func getPolls(page: Int, size: Int = 10, ageCategory: AgeCategory? = nil) {
        
        Network.shared.getPolls(page: page, size: size, ageCategory: ageCategory?.id) { [weak self] statusCode, polls, totalPages in
            guard let self else { return }
            guard let polls else {
                self.pushAlert(statusCode)
                self.updatePolls([], totalPages: 1)
                return
            }
            
            self.updatePolls(polls, totalPages: totalPages ?? 1)
        }
    }
    
    func getAgeCategories() {
        self.delegate?.indicatorView.startAnimating(.download)
        Network.shared.getAgeCategories { [weak self] statusCode, ageCategories in
            self?.delegate?.indicatorView.stopAnimating()
            guard let ageCategories else {
                self?.pushAlert(statusCode)
                return
            }
            
            self?.reloadAgeCategories(ageCategories)
        }
    }
}

extension PollViewPresenter {
    
    func updatePolls(_ polls: [PollingModel], totalPages: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.updatePolls(polls, totalPages: totalPages)
        }
    }
    
    func reloadAgeCategories(_ ageCategories: [AgeCategory]) {
        DispatchQueue.main.async {
            self.delegate?.reloadAgeCategories(ageCategories)
        }
    }
    
    func pushAlert(_ statusCode: StatusCode) {
        self.delegate?.alert(error: statusCode, action: nil)
    }
}
