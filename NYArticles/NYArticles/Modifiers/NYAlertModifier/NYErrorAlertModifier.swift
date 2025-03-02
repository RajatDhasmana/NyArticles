//
//  NYErrorAlertModifier.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 02/03/25.
//

import Foundation
import SwiftUI

struct ErrorStateViewModel: Equatable {
    static func == (lhs: ErrorStateViewModel, rhs: ErrorStateViewModel) -> Bool {
        lhs.error == rhs.error
    }

    var error: APIError?
    var retryClosure: (() -> Void)? = nil
}

struct NYErrorAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var errorStateVM: ErrorStateViewModel?
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                
                Alert(title: Text("Oops, something went wrong!"),
                      primaryButton: .cancel(Text("Okay"), action: { isPresented = false }),
                      secondaryButton: .default(Text("Retry"), action: {
                    isPresented = false
                    errorStateVM?.retryClosure?()
                }))
            }
    }
}

extension View {
    func showErrorAlert(isPresented: Binding<Bool>, errorStateVM: ErrorStateViewModel?) -> some View {
        self.modifier(NYErrorAlertModifier(isPresented: isPresented, errorStateVM: errorStateVM))
    }
}
