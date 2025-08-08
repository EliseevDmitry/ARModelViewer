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
    func configureForAR() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        session.run(config)
    }
    
    func addGestures(using coordinator: ARViewContainer.Coordinator) {
            [
                UITapGestureRecognizer(target: coordinator, action: #selector(coordinator.handleTap)),
                UIPinchGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePinch)),
                UIRotationGestureRecognizer(target: coordinator, action: #selector(coordinator.handleRotation)),
                UIPanGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePan))
            ].forEach { addGestureRecognizer($0) }
        }
    
    func translationDelta(from screenTranslation: CGPoint) -> SIMD3<Float> {
            let dx = Float(screenTranslation.x) * Constants.panSensitivity
            let dz = Float(screenTranslation.y) * Constants.panSensitivity

            let right = cameraTransform.matrix.columns.0
            let forward = cameraTransform.matrix.columns.2

            return dx * SIMD3(right.x, 0, right.z) + dz * SIMD3(forward.x, 0, forward.z)
        }
}
