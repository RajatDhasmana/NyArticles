//
//  RootCoordinator.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 02/03/25.
//

import Foundation

protocol RootCoordinator {
    associatedtype FlowScene: Hashable
    var navigationStack: [FlowScene] { get set }
}

extension RootCoordinator {
    mutating func push(flowScene: FlowScene) {
        navigationStack.append(flowScene)
    }
    
    mutating func pop() {
        _ = navigationStack.popLast()
    }
}

