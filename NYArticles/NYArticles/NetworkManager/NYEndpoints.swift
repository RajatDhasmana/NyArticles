//
//  NYEndpoints.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation
import Network

enum NYEndpoints {
    case articleList
}

extension NYEndpoints {
    var path: String {
        switch self {
        case .articleList:
            return "mostpopular/v2/mostviewed/all-sections/7.json"
        }
    }
}
