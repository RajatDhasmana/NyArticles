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
        return networkManager.makeRequest(with: ArticleListEndpoint.articleList, type: ArticleListResponse.self)
    }
}
