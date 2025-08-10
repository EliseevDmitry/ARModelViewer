//
//  Extension+View.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 06.08.2025.
//

import SwiftUI

extension View {
    /// Adds a customizable Xmark button overlay aligned to the top trailing corner
    /// - Parameters:
    ///   - foregroundColor: The color of the Xmark button (default is red)
    ///   - font: The font applied to the button (default is `.stairsTitle()`)
    ///   - xmarkButton: A view builder closure providing the button content
    /// - Returns: A view with the Xmark button overlay
    func customXmarkButton<B: View>(
        foregroundColor: Color = .red,
        font: Font = .stairsTitle(),
        @ViewBuilder _ xmarkButton: () -> B
    ) -> some View {
        overlay(alignment: .topTrailing) {
            xmarkButton()
                .alignmentGuide(.top) { $0.height * -1/3 }
                .alignmentGuide(.trailing) { $0.width * 4/3 }
                .font(font)
                .foregroundStyle(foregroundColor)
        }
    }
    
    /// Adds a customizable onboarding view overlay aligned to the bottom with standard padding
    /// - Parameters:
    ///   - horizontalPadding: Horizontal padding for comfortable reading (default 16pt)
    ///   - bottomPadding: Bottom padding to avoid Home Indicator area (default 34pt)
    ///   - onboarding: A view builder closure providing the onboarding content
    /// - Returns: A view with the onboarding overlay at the bottom
    func customOnboardingView<B: View>(
        horizontalPadding: CGFloat = 16,
        bottomPadding: CGFloat = 34,
        @ViewBuilder _ onboarding: () -> B
    ) -> some View {
        overlay(alignment: .bottom) {
            onboarding()
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, bottomPadding)
        }
    }
}
