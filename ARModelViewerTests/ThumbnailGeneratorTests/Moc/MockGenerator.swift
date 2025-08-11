//
//  MockGenerator.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import XCTest
@testable import ARModelViewer


final class MockGenerator: IThumbnailGenerator {
    var imageToReturn: UIImage?
    var errorToReturn: Error?
}

// MARK: - Public Functions
extension MockGenerator {
    func generate(for url: URL, size: CGSize) async throws -> UIImage {
        if let error = errorToReturn {
            throw error
        }
        guard let image = imageToReturn else {
            throw ARModelViewerErrors.thumbnailGenerationFailed(underlyingError: nil)
        }
        return image
    }
}
