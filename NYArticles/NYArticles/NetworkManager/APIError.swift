//
//  APIError.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation

enum APIError: Error {
    
    case url(URLError?)
    case badResponse(statusCode: Int)
    case unknown(Error)
    case decodingError(errorDesc: String)
    case invalidResponse
    
    static func convert(error: Error) -> APIError {
        switch error {
            
        case is URLError:
            return .url(error as? URLError)
            
        case is APIError:
            return error as! APIError
            
        case is DecodingError:
            return .decodingError(errorDesc: error.localizedDescription)
            
        default:
            return .unknown(error)
        }
    }
        
    var shownError: String { AppConstant.shownError.rawValue }
    var errorId: Int {
        switch self {
        case .url(let uRLError):
            return 0
        case .badResponse(let statusCode):
            return 1
        case .unknown(let error):
            return 2
        case .decodingError(let errorDesc):
            return 3
        case .invalidResponse:
            return 4
        }
    }
}

extension APIError: Equatable {
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        lhs.errorId == rhs.errorId
    }
}

