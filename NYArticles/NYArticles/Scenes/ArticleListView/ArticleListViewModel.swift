//
//  ArticleListViewModel.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation
import Combine

internal class ArticleListViewModel: ObservableObject {
    
    // MARK: - Published variables
    @Published var viewState: ViewState = .loading
    
    // MARK: - Private variables
    private let articleListRepo: ArticleListRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var router: ArticleListRouter
    
    var isRequestMade: Bool = false
    var viewConstants = ViewConstant()
    
    init(articleListRepo: ArticleListRepositoryProtocol, router: ArticleListRouter) {
        self.articleListRepo = articleListRepo
        self.router = router
    }
}

extension ArticleListViewModel {
    
    func perform(action: ArticleListViewActions) {
        switch action {
        case .didAppear:
            if !isRequestMade {
                getArticleList()
                isRequestMade = true
            }
        case .retry:
            getArticleList()
            
        case .didTapOnArticle(let article):
            router.moveToArticleDetail?(article)
        }
    }
    
    private func getArticleList() {
        viewState = .loading
        articleListRepo.fetchArticles()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let errorStateViewModel = ErrorStateViewModel(error: error) {
                        self?.perform(action: .retry)
                    }
                    self?.viewState = .failure(errorStateViewModel)
                }
            } receiveValue: { [weak self] articleResponse in
                if articleResponse.results.isEmpty {
                    let emptyStateViewModel = EmptyStateViewModel(emptyStateText: AppConstant.emptyDataViewText.rawValue) {
                        self?.perform(action: .retry)
                    }
                    self?.viewState = .emptyData(emptyStateViewModel)
                } else {
                    self?.viewState = .dataReceived(articleResponse.results)
                }
            }
            .store(in: &cancellables)
    }
}

extension ArticleListViewModel {
    enum ViewState: Equatable {
        case loading
        case failure(ErrorStateViewModel)
        case dataReceived([Article])
        case emptyData(EmptyStateViewModel)
    }
    
    enum ArticleListViewActions {
        case didAppear
        case retry
        case didTapOnArticle(_: Article)
    }
    
    struct ViewConstant {
        let navTitle = "NY Times Most Popular"
    }
}
