//
//  ArticleDetailViewModel.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation

struct ArticleDetailViewModel {
    
    struct Constant {
        let navTitle = "NY Times Most Popular"
    }

    let article: Article
    var viewConstants = Constant()
}
