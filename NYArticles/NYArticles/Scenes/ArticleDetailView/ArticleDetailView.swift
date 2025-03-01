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
                    AsyncImage(url: viewModel.article.imageUrl) { image in
                        image
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.4)

                    Text(viewModel.article.title)
                        .padding(.horizontal)
                        .font(.headline)
                    
                    Text(viewModel.article.abstract)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)

                    HStack(spacing: 5) {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(viewModel.article.publishedDate)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
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
