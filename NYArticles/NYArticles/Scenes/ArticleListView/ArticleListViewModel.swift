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
    var isRequestMade: Bool = false
    var viewConstants = ViewConstant()
    
    init(articleListRepo: ArticleListRepositoryProtocol) {
        self.articleListRepo = articleListRepo
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
    }
    
    struct ViewConstant {
        let navTitle = "NY Times Most Popular"
    }
}
