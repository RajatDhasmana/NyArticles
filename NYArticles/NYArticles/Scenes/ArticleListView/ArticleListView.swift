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
        
        List(viewModel.articles, id: \.id) { article in
            ArticleCellView(article: article)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    viewModel.perform(action: .didTapOnArticle(article))
                }
        }
        .listStyle(.plain)
        .overlay(content: {
            if viewModel.viewState == .loading {
                ProgressView()
            }
        })
        .withCustomNavBar(title: viewModel.viewConstants.navTitle)
        .onAppear(perform: {
            viewModel.perform(action: .didAppear)
        })
        .navigationBarBackButtonHidden(true)
        .showErrorAlert(isPresented: $viewModel.showErrorAlert, errorStateVM: viewModel.errorStateVM)
    }
}

#Preview {
    ArticleCellView(article: Article(url: "", id: 0, publishedDate: "", byline: "", title: "", abstract: "", media: []))
}

