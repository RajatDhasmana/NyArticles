//
//  ConfigurationManager.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

private enum BuildConfiguration {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let str as String:
            guard let value = T(str) else {fallthrough}
            return value
            
        default:
            throw Error.invalidValue
        }
    }
}

final class ConfigurationManager {
    
    static let shared = ConfigurationManager()
    
    var baseURL: String! {
        return "https://\(url!)"
    }
    var apiKey: String!
    private var url: String!
    
    private init() {
        setupValues()
    }
    
    private func setupValues() {
        do {
            url = try BuildConfiguration.value(for: "BASE_URL")
            apiKey = try BuildConfiguration.value(for: "API_KEY")

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
