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
/// Error indicating failure to obtain or use the screen scale for thumbnail generation
enum ARModelViewerErrors: Error {
    case thumbnailGenerationFailed(underlyingError: Error?)
    case thumbnailScaleError
}
