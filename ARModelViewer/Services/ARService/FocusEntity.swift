//
//  FocusEntity.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 31.07.2025.
//

import RealityKit
import ARKit
import UIKit

final class FocusEntity: Entity, HasModel, HasAnchoring {
    weak var arView: ARView?
    
    // MARK: - Initialization
    init(arView: ARView) {
        super.init()
        self.arView = arView
        addStartPoint(
            plane:
                PlaneSize(
                    width: StartPointConstants.planeWidth,
                    depth: StartPointConstants.planeDepth,
                    cornerRadius: StartPointConstants.cornerRadius
                )
        )
        arView.scene.addAnchor(self)
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
}

// MARK: - Private Functions
extension FocusEntity {
    private func addStartPoint(plane: PlaneSize, color: UIColor = StartPointConstants.startPointColor) {
        guard arView != nil else { return }
        // Create start point entity
        let mesh = MeshResource.generatePlane(
            width: plane.width,
            depth: plane.depth,
            cornerRadius: plane.cornerRadius
        )
        // Set material to start point entity
        let material = SimpleMaterial(
            color: color.withAlphaComponent(StartPointConstants.colorAlphaComponent),
            isMetallic: true
        )
        // Creating a model component and anchoring the entity in world coordinates
        self.model = ModelComponent(mesh: mesh, materials: [material])
        self.anchoring = AnchoringComponent(.world(transform: matrix_identity_float4x4))
    }
}

// MARK: - Public Functions
extension FocusEntity {
    func updateStartPoint() {
        guard let arView = arView else {
            isEnabled = false
            return
        }
        //Definition of the screen center
        let center = CGPoint(
            x: arView.bounds.midX,
            y: arView.bounds.midY
        )
        //Definition of the plane for placing the StartPoint
        guard let result = arView.raycast(
            from: center, allowing: .estimatedPlane,
            alignment: .horizontal
        ).first else {
            isEnabled = false
            return
        }
        //Updating the position
        transform = Transform(matrix: result.worldTransform)
        isEnabled = true
    }
}
