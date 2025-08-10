//
//  Extension+ModelEntity.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import SwiftUI
import ARKit
import RealityKit

extension ModelEntity {
    /// Clamps the entity's scale within given minimum and maximum bounds
    func clampScale(_ scale: SIMD3<Float>, minScale: SIMD3<Float>, maxScale: SIMD3<Float>) {
        let clamped = SIMD3<Float>(
            x: Swift.min(Swift.max(scale.x, minScale.x), maxScale.x),
            y: Swift.min(Swift.max(scale.y, minScale.y), maxScale.y),
            z: Swift.min(Swift.max(scale.z, minScale.z), maxScale.z)
        )
        setScale(clamped, relativeTo: nil)
    }
    
    /// Rotates the entity by a specified angle around the Y-axis
    func rotate(by angle: Float) {
        let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
        orientation *= rotation
    }
    
    /// Moves the entity by a given delta vector
    func move(by delta: SIMD3<Float>) {
        var position = self.position(relativeTo: nil)
        position += delta
        setPosition(position, relativeTo: nil)
    }
    
    /// Sets the entity's position and orientation relative to another entity
    func setTransform(relativeTo entity: Entity?, position: SIMD3<Float>, orientation: simd_quatf) {
        setPosition(position, relativeTo: entity)
        setOrientation(orientation, relativeTo: entity)
    }
}
