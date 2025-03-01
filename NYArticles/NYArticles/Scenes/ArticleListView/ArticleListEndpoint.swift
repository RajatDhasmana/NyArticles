//
//  ArticleListEndpoint.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 02/03/25.
//

import Foundation

enum ArticleListEndpoint: NYEndpoints {
    
    case articleList
    
    var path: String {
        switch self {
        case .articleList:
            return "mostpopular/v2/mostviewed/all-sections/7.json"
        }
    }
    
    var method: HTTPMethod? {
        switch self {
        case .articleList:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .articleList:
            return nil
        }
    }
    
    var parameters: NYRequestParameters? {
        switch self {
        case .articleList:
            return .url(["api-key": apiKey])
        }
    }
}
