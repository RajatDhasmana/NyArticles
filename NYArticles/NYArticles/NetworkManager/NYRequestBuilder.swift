//
//  NYRequestBuilder.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

final class NYRequestBuilder: NYRequestBuilderProtocol {
    
    private var baseURL: URL
    private var path: String
    private var method: HTTPMethod?
    private var headers: [String: String]?
    private var parameters: NYRequestParameters?
    
    init(baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.path = path
    }
        
    @discardableResult
    func set(method: HTTPMethod?) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    func set(path: String) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult
    func set(headers: [String : String]?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func set(parameters: NYRequestParameters?) -> Self {
        self.parameters = parameters
        return self

    }
    
    func build() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 50)
        urlRequest.httpMethod = method?.rawValue
        urlRequest.allHTTPHeaderFields = headers
        setupBody(urlRequest: &urlRequest)
        return urlRequest
    }
    
    private func setupBody(urlRequest: inout URLRequest) {
        if let parameters = parameters {
            
            switch parameters {
            case .body(let bodyParam):
                setupRequestBody(bodyParam, for: &urlRequest)
            case .url(let urlParam):
                setupRequestURLBody(urlParam, for: &urlRequest)
            }
        }
    }
    
    private func setupRequestBody(_ parameters: [String: Any]?, for request: inout URLRequest) {
        if let parametrs = parameters {
            let data = try? JSONSerialization.data(withJSONObject: parametrs, options: [])
            request.httpBody = data
        }
    }
    
    private func setupRequestURLBody(_ parameters: [String: String]?, for request: inout URLRequest) {
        if let parametrs = parameters,
           let url = request.url,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
            request.url = urlComponents.url
        }
    }
}
