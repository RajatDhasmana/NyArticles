//
//  DownloadImageService.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation
import Combine
import UIKit

protocol DownloadImageServiceProtocol {
    func downloadImage(url: URL) -> AnyPublisher<UIImage, ImageDownloadError>
}

struct DownloadImageService: DownloadImageServiceProtocol {
    func downloadImage(url: URL) -> AnyPublisher<UIImage, ImageDownloadError> {
        let cache = ImageCache.shared
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return Just(cachedImage)
                .setFailureType(to: ImageDownloadError.self)
                .eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, _ in
                guard let image = UIImage(data: data) else {
                    throw ImageDownloadError.downloadError
                }
                cache.setObject(image, forKey: url as NSURL)
                return image
            }
            .mapError({ error in
                ImageDownloadError.downloadError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum ImageDownloadError: Error {
    case downloadError
    case notAbleToConvertDataToImage
    
    var errorDescription: String? {
        switch self {
        case .downloadError:
            return "Download Error"
        case .notAbleToConvertDataToImage:
            return "Error while converting data to image"
        }
    }
}

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}
