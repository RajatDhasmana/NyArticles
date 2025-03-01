//
//  EmptyStateView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct EmptyStateView: View {
    
    let viewModel: EmptyStateViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Image(systemName: "folder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(viewModel.emptyStateText)
                .font(.headline)
            
            Spacer()
            
            Button {
                viewModel.retryClosure?()
            } label: {
                Text("Retry")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 100, height: 50)
            }
            .background(Color.blue)
            .cornerRadius(25)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(viewModel: .init(emptyStateText: AppConstant.emptyDataViewText.rawValue))
}
