//
//  ARViewContainer.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 31.07.2025.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    // Inject external ModelEntity from SwiftUI to be used inside makeCoordinator and ARView setup
    let modelEntity: ModelEntity

    // Create the Coordinator responsible for managing ARView interactions and data flow
    func makeCoordinator() -> Coordinator {
        Coordinator(model: modelEntity)
    }
    
    // Create and configure the ARView UIKit component for integration with SwiftUI
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let focusEntity = FocusEntity(arView: arView)
        arView.configureForAR()
        arView.addGestures(using: context.coordinator)
        context.coordinator.updateCoordinator(arView: arView, focusEntity: focusEntity)
        return arView
    }

    // Update the existing ARView when SwiftUI state changes
    func updateUIView(_ uiView: ARView, context: Context) {}
}
