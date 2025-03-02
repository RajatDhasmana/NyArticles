//
//  ArticleDetailViewModelTests.swift
//  NYArticlesTests
//
//  Created by Rajat Dhasmana on 02/03/25.
//

import XCTest
@testable import NYArticles

class ArticleDetailViewModelTests: XCTestCase {
    
    func testArticleDetailViewModelInitialization() {
        let testArticle = Article.mock
        let viewModel = ArticleDetailViewModel(article: testArticle)
        
        XCTAssertEqual(viewModel.article.title, "article title")
        XCTAssertEqual(viewModel.article.abstract, "Description")
        XCTAssertEqual(viewModel.viewConstants.navTitle, "NY Times Most Popular")
    }
}
