//
//  ArticleFlowCoordinator.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 02/03/25.
//

import Foundation
import SwiftUI

struct ArticleFlowCoordinator: View, RootCoordinator {
    
    enum Scenes: Hashable {
        case articleDetail(article: Article)
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
        }
        
        private var id: Int {
            switch self {
            case .articleDetail:
                return 1
            }
        }
    }
    
    @State var navigationStack: [Scenes] = []
    
    var body: some View {
        
        NavigationStack(path: $navigationStack) {
            resolveArticleListView()
                .navigationDestination(for: Scenes.self) { [self] scene in
                    switch scene {
                    case .articleDetail(let article):
                        self.resolveArticleDetailView(article: article)
                    }
                }
        }
    }
}


extension ArticleFlowCoordinator {
    
    private func resolveArticleListView() -> some View {
        
        let articleListRepo = ArticleListRepository(networkManager: NYNetworkManager())
        
        var articleListRouter = ArticleListRouter()
        articleListRouter.moveToArticleDetail = { article in
            self.push(item: .articleDetail(article: article))
        }

        let articleListVM = ArticleListViewModel(articleListRepo: articleListRepo, router: articleListRouter)
        let view = ArticleListView(viewModel: articleListVM)
        return view
    }
    
    private func resolveArticleDetailView(article: Article) -> some View {
        let articleDetailVM = ArticleDetailViewModel(article: article)
        let view = ArticleDetailView(viewModel: articleDetailVM)
        return view
    }
        
    func push(item: Scenes) {
        navigationStack.append(item)
    }
}

