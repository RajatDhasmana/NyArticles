//
//  ErrorStateViewModel.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation

struct ErrorStateViewModel: Equatable {    
    static func == (lhs: ErrorStateViewModel, rhs: ErrorStateViewModel) -> Bool {
        lhs.error == rhs.error
    }

    let error: APIError
    var retryClosure: (() -> Void)? = nil
}
