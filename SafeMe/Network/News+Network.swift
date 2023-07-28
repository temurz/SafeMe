//
//  News+Network.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

extension Network {
    
    //MARK: Get News
    func getNews(completion: @escaping (StatusCode, [News]?) -> ()) {
        
        let api = Api.news
        
        push(api: api, body: nil, headers: nil, type: NewsModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
