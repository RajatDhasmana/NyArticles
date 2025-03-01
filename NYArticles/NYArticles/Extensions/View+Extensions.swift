//
//  View+Extensions.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation
import SwiftUI

extension View {
    func withCustomNavBar(title: String) -> some View {
        self.modifier(CustomNavBarModifier(title: title))
    }
}
