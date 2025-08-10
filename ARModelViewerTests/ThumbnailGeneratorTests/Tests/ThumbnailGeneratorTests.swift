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
        
    func testGetImageReturnsImage() async throws {
        // given
        let mock = MockGenerator()
        let expectedImage = try XCTUnwrap(UIImage(systemName: "star"))
        mock.imageToReturn = expectedImage
        
        let viewModel = ModelItemViewModel(generator: mock)
        
        // when
        try await viewModel.getImageAndName(url: URL(fileURLWithPath: "/dummy/path"))
        
        // then
        XCTAssertEqual(viewModel.image?.pngData(), expectedImage.pngData())
    }
    
    func testGetImageThrowsThumbnailGenerationFailedError() async {
        // given
        let mock = MockGenerator()
        mock.errorToReturn = ARModelViewerErrors.thumbnailGenerationFailed(underlyingError: nil)
        
        let viewModel = ModelItemViewModel(generator: mock)
        
        // when
        do {
            try await viewModel.getImageAndName(url: URL(fileURLWithPath: "/dummy/path"))
            XCTFail("Expected ARModelViewerErrors.thumbnailGenerationFailed to be thrown")
        }
        // then
        catch let error as ARModelViewerErrors {
            switch error {
            case .thumbnailGenerationFailed(let underlyingError):
                XCTAssertNil(underlyingError)
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}
