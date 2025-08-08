//
//  Extension+simd_float4.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import Foundation
import ARKit

extension simd_float4 {
    var xyz: SIMD3<Float> {
        return SIMD3(x, y, z)
    }
}
