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
    @Published var articles: [Article] = []
    @Published var showErrorAlert: Bool = false
    
    // MARK: - Private variables
    private let articleListRepo: ArticleListRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var router: ArticleListRouter?
    
    var isRequestMade: Bool = false
    var viewConstants = ViewConstant()
    var errorStateVM: ErrorStateViewModel?

    init(articleListRepo: ArticleListRepositoryProtocol, router: ArticleListRouter? = nil) {
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
            errorStateVM = nil
            showErrorAlert = false
            getArticleList()
            
        case .didTapOnArticle(let article):
            router?.moveToArticleDetail?(article)
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
                    self?.viewState = .failure
                    self?.errorStateVM = errorStateViewModel
                    self?.showErrorAlert = true
                }
            } receiveValue: { [weak self] articleResponse in
                self?.articles = articleResponse.results
                self?.viewState = .dataReceived
            }
            .store(in: &cancellables)
    }
}

extension ArticleListViewModel {
    enum ViewState {
        case loading
        case failure
        case dataReceived
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
