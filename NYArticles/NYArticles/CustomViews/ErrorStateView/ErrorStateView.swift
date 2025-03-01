//
//  ErrorStateView.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct ErrorStateView: View {
    
    let viewModel: ErrorStateViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(viewModel.error.shownError)
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
    ErrorStateView(viewModel: .init(error: .noResponse))
}
