//
//  QuickLookThumbnailGenerator.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import SwiftUI
import QuickLookThumbnailing

protocol IThumbnailGenerator {
    func generate(for url: URL, size: CGSize) async throws -> UIImage
}

final class ThumbnailGenerator: IThumbnailGenerator { }

// MARK: - Public Functions
extension ThumbnailGenerator {
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
                    continuation.resume(throwing: error ?? NSError(domain: "ThumbnailError", code: -1))
                }
            }
        }
    }
}

