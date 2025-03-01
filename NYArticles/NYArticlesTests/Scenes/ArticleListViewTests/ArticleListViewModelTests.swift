//
//  ArticleListViewModelTests.swift
//  NYArticlesTests
//
//  Created by Rajat Dhasmana on 01/03/25.
//

import XCTest
@testable import NYArticles

final class ArticleListViewModelTests: XCTestCase {

    
    var viewModel: ArticleListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testResponseSuccess() throws {
        viewModel = ArticleListViewModel(articleListRepo: ArticleListRepoMocks.mockSuccess)
        XCTAssertEqual(viewModel.isRequestMade, false)
        XCTAssertEqual(viewModel.viewState, .loading)
        viewModel.perform(action: .didAppear)
        XCTAssertEqual(viewModel.isRequestMade, true)
        XCTAssertEqual(viewModel.viewState, .dataReceived(ArticleListResponse.mock.results))

    }
    
    func testResponseFailure() throws {
        viewModel = ArticleListViewModel(articleListRepo: ArticleListRepoMocks.mockFailure)
        XCTAssertEqual(viewModel.viewState, .loading)
        XCTAssertEqual(viewModel.isRequestMade, false)
        viewModel.perform(action: .didAppear)
        XCTAssertEqual(viewModel.isRequestMade, true)
        XCTAssertEqual(viewModel.viewState, .failure(.init(error: .invalidResponse)))
    }
    
    func testEmptyResponse() throws {
        viewModel = ArticleListViewModel(articleListRepo: ArticleListRepoMocks.mockEmptyResponse)
        XCTAssertEqual(viewModel.viewState, .loading)
        XCTAssertEqual(viewModel.isRequestMade, false)
        viewModel.perform(action: .didAppear)
        XCTAssertEqual(viewModel.isRequestMade, true)
        XCTAssertEqual(viewModel.viewState, .emptyData(.init(
            emptyStateText: AppConstant.emptyDataViewText.rawValue)))
    }
}
