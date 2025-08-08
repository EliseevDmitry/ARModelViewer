//
//  ARViewCoordinator.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import SwiftUI
import RealityKit

final class Coordinator: NSObject {
    private weak var arView: ARView?
    private var focusEntity: FocusEntity?
    private var focusTimer: Timer?
    private var modelEntity: ModelEntity
    private var isPlaced = false
    var initialBoundingBox: SIMD3<Float>?
    var initialScale: SIMD3<Float>?
    
    // MARK: - Initialization
    
    init(model: ModelEntity) {
        self.modelEntity = model
        self.initialBoundingBox = model.visualBounds(relativeTo: nil).extents
        self.initialScale = model.scale(relativeTo: nil)
    }

    deinit {
        focusTimer?.invalidate()
    }

}

// MARK: - Public Functions
extension Coordinator {
    
    func updateCoordinator(arView: ARView, focusEntity: FocusEntity) {
        self.arView = arView
        self.focusEntity = focusEntity

        focusTimer = Timer.scheduledTimer(withTimeInterval: Constants.focusUpdateInterval, repeats: true) { [weak focusEntity] _ in
            DispatchQueue.main.async {
                focusEntity?.updateStartPoint()
            }
        }
    }
    
}

// MARK: - Private Functions

extension Coordinator {
    private func setupAfterPlacement() {
        focusEntity?.isEnabled = false
        focusTimer?.invalidate()
        focusTimer = nil
        isPlaced = true
    }
}


extension Coordinator {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard !isPlaced, let arView = arView, let focusEntity = focusEntity else { return }

        let position = focusEntity.transform.translation
        let rotation = arView.cameraTransform.yawRotation

        let anchor = AnchorEntity(world: position)
        modelEntity.setTransform(relativeTo: nil, position: .zero, orientation: rotation)
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)

        setupAfterPlacement()
    }

    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.state == .changed, let initialScale = initialScale else { return }

        let scaleDelta = Float(gesture.scale)
        gesture.scale = 1

        let currentScale = modelEntity.scale(relativeTo: nil) * scaleDelta
        modelEntity.clampScale(currentScale, minScale: initialScale * Constants.minScaleFactor, maxScale: initialScale * Constants.maxScaleFactor)
    }

    @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        guard gesture.state == .changed else { return }

        let angle = -Float(gesture.rotation)
        modelEntity.rotate(by: angle)
        gesture.rotation = 0
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let arView = arView else { return }

        let translation = gesture.translation(in: arView)
        gesture.setTranslation(.zero, in: arView)

        let delta = arView.translationDelta(from: translation)
        modelEntity.move(by: delta)
    }
}
