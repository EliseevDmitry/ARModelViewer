//
//  AROnboardingView.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 05.08.2025.
//

import SwiftUI

struct AROnboardingView: View {
    @StateObject
    private var viewModel: AROnboardingViewModel
    init(viewModel: AROnboardingViewModel = AROnboardingViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        Group {
            if !viewModel.didFinishOnboarding {
                ZStack{
                    backgroundCard
                    onboardingCardData
                }
                .frame(height: 150)
            }
        }
    }
    
    private var onboardingCardData: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: viewModel.data.systemImageName)
                    .font(.system(size: 60))
                    .padding()
                Text(viewModel.data.text)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .transition(.opacity.combined(with: .slide))
            .animation(.easeInOut, value: viewModel.data.text)
        }
    }
    
    private var backgroundCard: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(Onboarding.cardColor)
            .customXmarkButton{
                Button {
                    viewModel.skipOnboarding()
                } label: {
                    Image(systemName: Onboarding.icon)
                }
            }
    }
}


#Preview {
    AROnboardingView()
}
