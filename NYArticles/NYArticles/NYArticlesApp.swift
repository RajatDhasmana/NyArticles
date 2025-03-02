//
//  NYArticlesApp.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import SwiftUI

@main
struct NYArticlesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ArticleFlowCoordinator()
        }
    }
}
