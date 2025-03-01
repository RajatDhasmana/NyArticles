//
//  APIError.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

enum APIError: Error, Equatable {
    
    case notAbleToDecode
    case noResponse
    case invalidUrl
    case unAuthorised
    case unknown(errorStr: String)
    
    init(statusCode: Int, error: Error) {
        
        switch statusCode {
        case 204:
            self = .notAbleToDecode
        case 400:
            self = .invalidUrl
        case 401:
            self = .noResponse
        case 405:
            self = .unAuthorised
        default:
            self = .unknown(errorStr: error.localizedDescription)
        }
    }
    
    init(error: Error) {
        switch error {
            
        case is URLError:
            self = .invalidUrl
            
        default:
            self = .unknown(errorStr: error.localizedDescription)
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .notAbleToDecode:
            return AppConstant.notAbleToDecodeError.rawValue
        case .noResponse:
            return AppConstant.noResponseError.rawValue
        case .invalidUrl:
            return AppConstant.invalidUrlError.rawValue
        case .unAuthorised:
            return AppConstant.unAuthorisedError.rawValue
        case .unknown(let errorStr):
            return errorStr
        }
    }
    
    var shownError: String { AppConstant.shownError.rawValue }
}

