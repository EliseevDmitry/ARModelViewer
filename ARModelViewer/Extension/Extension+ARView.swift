//
//  Extension+ARView.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import Foundation
import RealityKit
import ARKit

extension ARView {
    /// Configures ARView with standard world tracking and horizontal plane detection
    func configureForAR() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        session.run(config)
    }
    
    /// Adds common gesture recognizers (tap, pinch, rotation, pan) using the given coordinator
    func addGestures(using coordinator: ARViewContainer.Coordinator) {
            [
                UITapGestureRecognizer(
                    target: coordinator,
                    action: #selector(coordinator.handleTap)
                ),
                UIPinchGestureRecognizer(
                    target: coordinator,
                    action: #selector(coordinator.handlePinch)
                ),
                UIRotationGestureRecognizer(
                    target: coordinator,
                    action: #selector(coordinator.handleRotation)
                ),
                UIPanGestureRecognizer(
                    target: coordinator,
                    action: #selector(coordinator.handlePan)
                )
            ].forEach { addGestureRecognizer($0) }
        }
    
    /// Converts screen translation (pan gesture) into 3D world translation vector
    func translationDelta(from screenTranslation: CGPoint) -> SIMD3<Float> {
            let dx = Float(screenTranslation.x) * Constants.panSensitivity
            let dz = Float(screenTranslation.y) * Constants.panSensitivity
            let right = cameraTransform.matrix.columns.0
            let forward = cameraTransform.matrix.columns.2
            return dx * SIMD3(right.x, 0, right.z) + dz * SIMD3(forward.x, 0, forward.z)
        }
}
