//
//  ArticleListResponse.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation

// MARK: - ArticleListResponse
struct ArticleListResponse: Decodable {
    let status, copyright: String
    let numResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Article
struct Article: Decodable, Equatable {
    let url: String
    let id: Int
    let publishedDate: String
    let byline: String
    let title, abstract: String
    let media: [Media]
    
    var imageUrlStr: String? {
        return media.last?.mediaMetadata.last?.url
    }
    
    var imageUrl: URL? {
        return URL(string: media.last?.mediaMetadata.last?.url ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case url, id
        case publishedDate = "published_date"
        case byline, title, media, abstract
    }
}

// MARK: - Media
struct Media: Decodable, Equatable {
    let type: MediaType
    let subtype: Subtype
    let caption, copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]
    
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Decodable, Equatable {
    let url: String
    let format: Format
    let height, width: Int
}

// MARK: - Format
enum Format: String, Decodable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

// MARK: - Subtype
enum Subtype: String, Decodable {
    case empty = ""
    case photo = "photo"
}

// MARK: - MediaType
enum MediaType: String, Decodable {
    case image = "image"
}
