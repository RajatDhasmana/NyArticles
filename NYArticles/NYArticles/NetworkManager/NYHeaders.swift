//
//  NYHeaders.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

class NYHeaders {
    static var defaultHeaders: [String: String] {
        let headers: [String: String] = [
            "api-key": ConfigurationManager.shared.apiKey
        ]
        return headers
    }
}
