//
//  ContentView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink {
                    ArticleListView(viewModel: ArticleListViewModel(articleListRepo: ArticleListRepository(networkManager: NYNetworkManager())))
                } label: {
                    Text("Click here to move to Article list screen")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
