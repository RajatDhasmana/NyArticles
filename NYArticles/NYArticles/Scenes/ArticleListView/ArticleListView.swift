//
//  ArticleListView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct ArticleListView: View {
    
    @ObservedObject var viewModel: ArticleListViewModel

    var body: some View {
        
        Group {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                
            case .failure(let errorStateViewModel):
                ErrorStateView(viewModel: errorStateViewModel)
                
            case .emptyData(let emptyStateViewModel):
                EmptyStateView(viewModel: emptyStateViewModel)
                
            case .dataReceived(let articleList):
                
                List(articleList, id: \.id) { article in
                    ArticleCellView(article: article)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .withCustomNavBar(title: viewModel.viewConstants.navTitle)
        .onAppear(perform: {
            viewModel.perform(action: .didAppear)
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ArticleCellView(article: Article(url: "", id: 0, publishedDate: "", byline: "", title: "", abstract: "", media: []))
}
