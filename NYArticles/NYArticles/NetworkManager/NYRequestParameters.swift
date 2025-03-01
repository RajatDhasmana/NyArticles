//
//  NYRequestParameters.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

enum NYRequestParameters {
    case body(_: [String: Any]?)
    case url(_: [String: String]?)
}
