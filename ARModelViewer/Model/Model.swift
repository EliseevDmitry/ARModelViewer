//
//  Model.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import SwiftUI

// Parameters for the StartPoint plane geometry
struct PlaneSize {
    let width: Float
    let depth: Float
    let cornerRadius: Float
}

// The Equatable protocol is implemented to support XCTAssertEqual() assertions in test cases
struct OnboardingStep: Equatable {
    let text: String
    let systemImageName: String
}

// In ForEach and .task(id:), the url is used as a unique identifier for correct re-rendering and task execution
struct USDZFile {
    let name: String
    let url: URL
}
