//
//  DownloadImageView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct DownloadImageView: View {
    
    @StateObject private var viewModel: DownloadImageViewModel
    
    init(urlString: String) {
        _viewModel = StateObject(wrappedValue: DownloadImageViewModel(
            urlStr: urlString,
            imageDownloadService: DownloadImageService()))
    }
    
    var body: some View {
        
        ZStack {
            
            switch viewModel.viewState {
            case .failure, .loading:
                ProgressView()
                
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onAppear {
            viewModel.perform(action: .didAppear)
        }
    }
}

#Preview {
    DownloadImageView(urlString: "")
}
