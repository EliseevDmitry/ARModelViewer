//
//  Extension+Transform.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import Foundation
import RealityKit

extension Transform {
    var translation: SIMD3<Float> {
        return self.matrix.columns.3.xyz
    }
    
    var yawRotation: simd_quatf {
            let forward = matrix.columns.2
            let yaw = atan2(forward.x, forward.z)
            return simd_quatf(angle: yaw, axis: [0, 1, 0])
        }
}
