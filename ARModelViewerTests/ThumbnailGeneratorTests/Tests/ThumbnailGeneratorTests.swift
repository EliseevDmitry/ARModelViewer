//
//  ThumbnailGeneratorTests.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import XCTest
@testable import ARModelViewer
import QuickLookThumbnailing

final class ThumbnailGeneratorTests: XCTestCase {
    // Tests that the thumbnail generator returns the expected UIImage when generation succeeds
    func testGetImageReturnsImage() async throws {
        // Given
        let mock = MockGenerator()
        let expectedImage = try XCTUnwrap(UIImage(systemName: "star"))
        mock.imageToReturn = expectedImage
        let viewModel = ModelItemViewModel(generator: mock)
        
        // When
        try await viewModel.getImageAndName(url: URL(fileURLWithPath: "/dummy/path"))
        
        // Then
        XCTAssertEqual(viewModel.image?.pngData(), expectedImage.pngData())
    }
    
    // Tests that the thumbnail generator throws a thumbnailGenerationFailed error when generation fails
    func testGetImageThrowsThumbnailGenerationFailedError() async {
        // Given
        let mock = MockGenerator()
        mock.errorToReturn = ARModelViewerErrors.thumbnailGenerationFailed(underlyingError: nil)
        let viewModel = ModelItemViewModel(generator: mock)
        
        // When
        do {
            try await viewModel.getImageAndName(url: URL(fileURLWithPath: "/dummy/path"))
            XCTFail("Expected ARModelViewerErrors.thumbnailGenerationFailed to be thrown")
        }
        
        // Then
        catch let error as ARModelViewerErrors {
            switch error {
            case .thumbnailGenerationFailed(let underlyingError):
                XCTAssertNil(underlyingError)
            case .thumbnailScaleError:
                XCTFail("Expected thumbnailGenerationFailed but got thumbnailScaleError")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
