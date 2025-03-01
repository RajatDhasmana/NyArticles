//
//  NYNetworkManager.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import Foundation
import Combine

protocol NYNetworkManagerProtocol {
    func makeRequest<T: Decodable>(with endpoint: NYEndpoints, type: T.Type, decoder: JSONDecoder) -> AnyPublisher<T, APIError>
}

extension NYNetworkManagerProtocol {
    func makeRequest<T: Decodable>(with endpoint: NYEndpoints, type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, APIError> {
        makeRequest(with: endpoint, type: type, decoder: decoder)
    }
}

class NYNetworkManager: NYNetworkManagerProtocol {
    func makeRequest<T: Decodable>(with endpoint: NYEndpoints, type: T.Type, decoder: JSONDecoder) -> AnyPublisher<T, APIError> {
        
            let request = endpoint.urlRequest
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.invalidResponse
                    }
                    
                    guard (200...299).contains(httpResponse.statusCode) else {
                        throw APIError.badResponse(statusCode: httpResponse.statusCode)
                    }
                    return data
                }
                .decode(type: T.self, decoder: decoder)
                .mapError { error in APIError.decodingError(errorDesc: error.localizedDescription) }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}
