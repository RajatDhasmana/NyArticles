//
//  NYRequest.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

protocol NYRequestBuilderProtocol {

    init(baseURL: URL, path: String)
    func set(method: HTTPMethod) -> Self
    func set(path: String) -> Self
    func set(headers: [String: String]?) -> Self
    func set(parameters: NYRequestParameters?) -> Self
    func build() throws -> URLRequest
}
