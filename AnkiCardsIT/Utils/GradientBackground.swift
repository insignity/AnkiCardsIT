//
//  GradientBackground.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 14.05.2025.
//
import SwiftUI

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [Color.primary1, Color.primary2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func gradientBackground() -> some View {
        self.modifier(GradientBackground())
    }
}
