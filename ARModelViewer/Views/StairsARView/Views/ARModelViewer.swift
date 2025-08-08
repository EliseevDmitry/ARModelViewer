//
//  StairsARView.swift
//  TestAugmentedRealityView
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import SwiftUI
import RealityFoundation

struct ARModelViewer: View {
    @StateObject
    private var viewModel: ARViewerViewModel
    init(viewModel: ARViewerViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        Group{
            if let entity = viewModel.modelEntity {
                ARViewContainer(modelEntity: entity)
                    .customOnboardingView {
                        AROnboardingView()
                    }
            } else {
                ProgressView()
            }
        }
        .ignoresSafeArea()
        .task {
            await viewModel.getEntity()
        }
    }
}

#Preview {
    NavigationStack {
        ARModelViewer(viewModel: ARViewerViewModel(modelName: ""))
    }
}
