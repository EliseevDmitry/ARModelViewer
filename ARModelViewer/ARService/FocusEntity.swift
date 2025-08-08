//
//  CustomFocusEntity.swift
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
        addStartPoint(plane:
            PlaneSize(
                width: StartPointConstants.planeWidth,
                depth: StartPointConstants.planeDepth,
                cornerRadius: StartPointConstants.cornerRadius
            )
        )
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }

}

// MARK: - Private Functions
extension FocusEntity {
    
    private func addStartPoint(plane: PlaneSize, color: UIColor = StartPointConstants.startPointColor) {
        guard let arView = arView else { return }
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
        arView.scene.addAnchor(self)
    }
    
}

// MARK: - Public Functions
extension FocusEntity {
    
    func updateStartPoint() {
        guard let arView = arView else {
            self.isEnabled = false
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
            self.isEnabled = false
            return
        }
        //Updating the position
        self.transform = Transform(matrix: result.worldTransform)
        self.isEnabled = true
    }
    
}
