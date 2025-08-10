//
//  ARModelViewerErrors.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import Foundation

/// Custom error type representing failures during thumbnail image generation
/// from USDZ 3D model files
/// Includes an optional underlying error for detailed diagnostics
enum ARModelViewerErrors: Error {
    case thumbnailGenerationFailed(underlyingError: Error?)
}
