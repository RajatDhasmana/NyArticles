//
//  ArticleListViewMocks.swift
//  NYArticlesTests
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation
@testable import NYArticles
import Combine


struct ArticleListRepoMocks: ArticleListRepositoryProtocol {
    
    private var mockResponse: AnyPublisher<NYArticles.ArticleListResponse, NYArticles.APIError>
    
    init(mockResponse: AnyPublisher<NYArticles.ArticleListResponse, NYArticles.APIError>) {
        self.mockResponse = mockResponse
    }
    
    func fetchArticles() -> AnyPublisher<NYArticles.ArticleListResponse, NYArticles.APIError> {
       mockResponse
    }
}

extension ArticleListRepoMocks {
    
    static let mockSuccess: Self = {
        let response: AnyPublisher<NYArticles.ArticleListResponse, NYArticles.APIError> = Just(.mock)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        return ArticleListRepoMocks(mockResponse: response)
    }()
    
    
    static let mockFailure: Self = {
        let response: AnyPublisher<NYArticles.ArticleListResponse, NYArticles.APIError> = Fail(error: APIError.invalidResponse)
            .eraseToAnyPublisher()
        return ArticleListRepoMocks(mockResponse: response)
    }()
    
    static let mockEmptyResponse: Self = {
        let response: AnyPublisher<NYArticles.ArticleListResponse, NYArticles.APIError> = Just(.mockEmpty)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        return ArticleListRepoMocks(mockResponse: response)
    }()
}

extension Article {
    static let mock: Self = {
       return Article(url: "www.google.com", id: 1, publishedDate: "2024-10-16", byline: "by rajat", title: "article title", abstract: "Description", media: [])
    }()
}

extension ArticleListResponse {
    static let mock: Self = {
        return ArticleListResponse(status: "OK", copyright: "Copyright", numResults: 1, results: [.mock])
    }()
    
    static let mockEmpty: Self = {
        return ArticleListResponse(status: "OK", copyright: "Copyright", numResults: 0, results: [])
    }()
}

extension ErrorStateViewModel {
    
    static let mockInvalidResponse: Self = {
        let vm = ErrorStateViewModel(error: .invalidResponse)
        return vm
    }()
}
