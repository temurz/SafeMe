//
//  PollDetailViewPresenter.swift
//  SafeMe
//
//  Created by Temur on 18/08/2023.
//

import Foundation
protocol PollDetailViewPresenterProtocol {
    func reloadAnswers(_ answers: [Answer])
    func savedSuccessfully(_ statusCode: StatusCode)
}

typealias PollDetailViewPresenterDelegate = PollDetailViewPresenterProtocol & PollDetailViewController

class PollDetailViewPresenter {
    weak var delegate: PollDetailViewPresenterDelegate?
    
    func getAnswers(poll_id: Int) {
        Network.shared.getPollAnswers(poll_id: poll_id) { [weak self] statusCode, answers in
            guard let self else { return }
            guard let answers else {
                self.pushAlert(statusCode)
                return
            }
            self.updateAnswers(answers)
        }
    }
    
    func saveAnswer(question: Int, answer: Int) {
        Network.shared.saveAnswer(question: question, answer: answer) { [weak self] statusCode in
            guard let self else { return }
            if statusCode.code != 0 {
                self.pushAlert(statusCode)
                return
            }
            self.successfullySavedAction(statusCode)
        }
    }
}

extension PollDetailViewPresenter {
    func updateAnswers(_ answers: [Answer]) {
        DispatchQueue.main.async {
            self.delegate?.reloadAnswers(answers)
        }
        
    }
    
    func successfullySavedAction(_ statusCode: StatusCode) {
        DispatchQueue.main.async {
            self.delegate?.savedSuccessfully(statusCode)
        }
    }
    
    func pushAlert(_ statusCode: StatusCode) {
        self.delegate?.alert(error: statusCode, action: nil)
    }
}
