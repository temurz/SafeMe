//
//  News+Network.swift
//  SafeMe
//
//  Created by Temur on 28/07/2023.
//

import Foundation

extension Network {
    
    //MARK: Get News
    func getNews(page: Int, size: Int, completion: @escaping (StatusCode, [News]?, Int?) -> ()) {
        
        let api = Api.news
        
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "size", value: "\(size)")]
        var urlComponents = URLComponents(string: api.path)!
        urlComponents.queryItems = queryItems
        let newUrl = urlComponents.url!
        
        push(api: api, newUrl: newUrl,body: nil, headers: nil, type: NewsModel.self) { result in
            switch result {
            case .success(let model):
                completion(StatusCode(code: 200), model.body, model.total_pages)
            case .failure(let error):
                completion(error, nil, nil)
            }
        }
    }
}
