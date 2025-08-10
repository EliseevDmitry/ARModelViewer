//
//  QuickLookThumbnailGenerator.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import SwiftUI
import QuickLookThumbnailing

/// Protocol defining thumbnail generation from a URL,
/// enabling the creation of mock objects for testing and facilitating dependency injection
protocol IThumbnailGenerator {
    func generate(for url: URL, size: CGSize) async throws -> UIImage
}

final class ThumbnailGenerator: IThumbnailGenerator { }

// MARK: - Public Functions
extension ThumbnailGenerator {
    /// Asynchronous method to generate a thumbnail image for a file at a given URL and size
    /// Uses QLThumbnailGenerator from QuickLookThumbnailing to obtain the best available representation
    /// Throws a custom thumbnailGenerationFailed error in case of failure
    func generate(for url: URL, size: CGSize) async throws -> UIImage {
        let request = await QLThumbnailGenerator.Request(
            fileAt: url,
            size: size,
            scale: UIScreen.main.traitCollection.displayScale,
            representationTypes: .all
        )
        let generator = QLThumbnailGenerator.shared
        return try await withUnsafeThrowingContinuation { continuation in
            generator.generateBestRepresentation(for: request) { thumbnail, error in
                if let image = thumbnail?.uiImage {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(
                        throwing: ARModelViewerErrors.thumbnailGenerationFailed(underlyingError: error)
                    )
                }
            }
        }
    }
}
