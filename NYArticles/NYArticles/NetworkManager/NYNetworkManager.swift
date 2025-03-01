//
//  NYNetworkManager.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation
import Combine

protocol NYNetworkManagerProtocol {
    func makeRequest<T: Decodable>(with builder: NYRequestBuilder, type: T.Type) -> AnyPublisher<T, APIError>
}

class NYNetworkManager: NYNetworkManagerProtocol {
    func makeRequest<T: Decodable>(with builder: NYRequestBuilder, type: T.Type) -> AnyPublisher<T, APIError> {
        
        do {
            let request = try builder.build()
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        throw APIError.unknown(errorStr: "Bad Response Code")
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    if error is DecodingError {
                        return APIError.notAbleToDecode
                    } else if let error = error as? APIError {
                        return error
                    } else {
                        return APIError.unknown(errorStr: "Unknown error occured")
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.invalidUrl).eraseToAnyPublisher()
        }
    }
}
