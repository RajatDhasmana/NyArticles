//
//  EmptyStateViewModel.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation

struct EmptyStateViewModel: Equatable {
    let emptyStateText: String
    var retryClosure: (() -> Void)?
    
    static func == (lhs: EmptyStateViewModel, rhs: EmptyStateViewModel) -> Bool {
        return lhs.emptyStateText == rhs.emptyStateText
    }
}
