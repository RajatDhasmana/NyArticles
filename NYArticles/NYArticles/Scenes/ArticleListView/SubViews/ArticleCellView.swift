//
//  ArticleCellView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct ArticleCellView: View {
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        HStack {
//            DownloadImageView(urlString: article.imageUrlStr ?? "")
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
//            
//            AsyncImage(url: article.imageUrl)
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
            
            AsyncImage(url: article.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)

            
            VStack(alignment: .leading, spacing: 5) {
                Text(article.title)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                HStack(alignment: .bottom) {
                    Text(article.byline)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(article.publishedDate)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding([.leading, .trailing], 10)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    ArticleCellView(article: Article(url: "temp", id: 0, publishedDate: "01-01-1111", byline: "temp", title: "temp", abstract: "", media: []))
}
