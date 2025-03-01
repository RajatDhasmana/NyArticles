//
//  ArticleListRepository.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation
import Combine

protocol ArticleListRepositoryProtocol {
    func fetchArticles() -> AnyPublisher<ArticleListResponse, APIError>
}

struct ArticleListRepository: ArticleListRepositoryProtocol {
    
    private var networkManager: NYNetworkManagerProtocol
    init(networkManager: NYNetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchArticles() -> AnyPublisher<ArticleListResponse, APIError> {
        guard let baseURL = URL(string: ConfigurationManager.shared.baseURL) else {
            return Fail(error: APIError.invalidUrl).eraseToAnyPublisher()
        }
        
        let request = NYRequestBuilder(baseURL: baseURL, path: NYEndpoints.articleList.path)
        request
            .set(method: .get)
            .set(parameters: .url(["api-key": ConfigurationManager.shared.apiKey]))
        return networkManager.makeRequest(with: request, type: ArticleListResponse.self)
    }
}
