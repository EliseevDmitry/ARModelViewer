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

struct OnboardingStep {
    let text: String
    let systemImageName: String
}

struct USDZFile: Identifiable {
    let id: UUID = UUID()
    let name: String
    let url: URL
}
