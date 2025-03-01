//
//  NYEndpoints.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation

protocol NYEndpoints {
    var baseURL: URL { get }
    var apiKey: String { get }
    var path: String { get }
    var method: HTTPMethod? { get }
    var headers: [String: String]? { get }
    var parameters: NYRequestParameters? { get }
    var urlRequest: URLRequest { get }
}

extension NYEndpoints {
    
    var baseURL: URL {
        guard let baseURL = URL(string: ConfigurationManager.shared.baseURL) else {
            fatalError("Base URL not found")
        }
        return baseURL
    }
    
    var apiKey: String {
        return ConfigurationManager.shared.apiKey
    }
    
    var urlRequest: URLRequest {
        let request = NYRequestBuilder(baseURL: baseURL, path: path)
        return request
            .set(method: method)
            .set(parameters: parameters)
            .set(headers: headers)
            .build()
    }
}
