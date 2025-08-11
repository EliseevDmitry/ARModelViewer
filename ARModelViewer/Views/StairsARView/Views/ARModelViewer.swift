//
//  ARModelViewer.swift
//  TestAugmentedRealityView
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import SwiftUI
import RealityFoundation

struct ARModelViewer: View {
    @StateObject
    private var viewModel: ARViewerViewModel
    let modelURL: URL
    init(url: URL) {
        self.modelURL = url
        _viewModel = StateObject(wrappedValue: ARViewerViewModel(url: url))
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
