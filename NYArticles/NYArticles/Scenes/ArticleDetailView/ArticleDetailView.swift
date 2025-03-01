//
//  ArticleDetailView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct ArticleDetailView: View {
    
    let viewModel: ArticleDetailViewModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    topImage(imageUrl: viewModel.article.imageUrl)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                    
                    titleText(text: viewModel.article.title)
                    
                    abstractText(text: viewModel.article.abstract)

                    publishedDateView(dateText: viewModel.article.publishedDate)
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle(viewModel.viewConstants.navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let article = Article(url: "", id: 0, publishedDate: "", byline: "", title: "", abstract: "", media: [])
    return ArticleDetailView(viewModel: .init(article: article))
}

extension ArticleDetailView {
    
    private func topImage(imageUrl: URL?) -> some View {
        
        AsyncImage(url: imageUrl) { image in
            image
        } placeholder: {
            ProgressView()
        }
    }
    
    private func titleText(text: String) -> some View {
        Text(text)
            .padding(.horizontal)
            .font(.headline)
    }
    
    private func abstractText(text: String) -> some View {
        Text(text)
            .padding(.horizontal)
            .multilineTextAlignment(.leading)
            .font(.subheadline)
    }
    
    private func publishedDateView(dateText: String) -> some View {
        HStack(spacing: 5) {
            Image(systemName: "calendar")
                .font(.caption)
                .foregroundColor(.gray)
            Text(dateText)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
