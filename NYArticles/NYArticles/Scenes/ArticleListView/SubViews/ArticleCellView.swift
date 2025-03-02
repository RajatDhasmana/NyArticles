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
            titleImageView(imageUrl: article.imageUrl)
            
            VStack(alignment: .leading, spacing: 5) {
                titleText(text: article.title)
                
                HStack(alignment: .bottom) {
                    bylineText(text: article.byline)
                    
                    Spacer()
                    
                    publishedDateView(dateText: article.publishedDate)
                }
            }
            .padding([.leading, .trailing], 10)
            
            Spacer()
            
            rightArrowImage
        }
    }
}

#Preview {
    ArticleCellView(article: Article(url: "temp", id: 0, publishedDate: "01-01-1111", byline: "temp", title: "temp", abstract: "", media: []))
}

extension ArticleCellView {
    
    private func titleImageView(imageUrl: URL?) -> some View {
        
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())

        } placeholder: {
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        }
        .frame(width: 40, height: 40)        
    }
    
    private func titleText(text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.black)
            .lineLimit(1)
    }
    
    private func bylineText(text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .font(.caption)
            .foregroundColor(.gray)
            .lineLimit(2)
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
    
    private var rightArrowImage: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(.gray)
    }
}
