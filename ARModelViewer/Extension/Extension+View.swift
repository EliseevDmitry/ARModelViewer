//
//  Extension+View.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 06.08.2025.
//

import SwiftUI

extension View {
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
    
    // Standard spacing based on Apple HIG:
    // 16pt horizontal padding for comfortable reading
    // 34pt bottom padding to avoid the Home Indicator area
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
