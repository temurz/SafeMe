//
//  PollViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 18/08/2023.
//

import Foundation

protocol PollViewPresenterProtocol {
    func updatePolls(_ polls: [PollingModel])
    func reloadAgeCategories(_ ageCategories: [AgeCategory])
}

typealias PollViewPresenterDelegate = PollViewPresenterProtocol & PollViewController

class PollViewPresenter {
    weak var delegate: PollViewPresenterDelegate?
    
    func getPolls(ageCategory: AgeCategory? = nil) {
        
        Network.shared.getPolls { [weak self] statusCode, polls in
            guard let self else { return }
            guard let polls else {
                self.pushAlert(statusCode)
                return
            }
            
            if let ageCategory = ageCategory {
                let filteredPolls = polls.filter({$0.ageCategory == ageCategory.id})
                self.updatePolls(filteredPolls)
                return
            }
            self.updatePolls(polls)
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
    
    func updatePolls(_ polls: [PollingModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.updatePolls(polls)
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
