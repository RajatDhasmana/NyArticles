//
//  CustomNavBar.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

struct CustomNavBar: View {
    
    var title: String
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea(edges: .top)
                .frame(height: 60)
            
            HStack {
                Button(action: {
                    print("Menu tapped")
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 15) {
                    Button(action: {
                        print("Search tapped")
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        print("More options tapped")
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CustomNavBar(title: "Custom Nav Bar")
}

struct CustomNavBarModifier: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            CustomNavBar(title: title)
            content
            Spacer()
        }
    }
}
