//
//  AppConstants.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import SwiftUI

/// Configuration constants for the `StartPoint` entity used in `FocusEntity`
/// Defines the plane dimensions, corner radius, transparency, and color used to visualize the start point in AR
struct StartPointConstants {
    static let planeWidth: Float = 0.1
    static let planeDepth: Float = 0.1
    static let cornerRadius: Float = 0.02
    static let colorAlphaComponent = 0.5
    static let startPointColor = UIColor.green
}

/// Constants used by `ARViewCoordinator` to control AR model interactions
/// Includes scaling limits, pan gesture sensitivity, and focus update timing
enum Constants {
    static let minScaleFactor: Float = 0.25
    static let maxScaleFactor: Float = 3.5
    static let panSensitivity: Float = 0.001
    static let focusUpdateInterval: TimeInterval = 0.1
}

/// Constants and sample data used by `AROnboardingView`
/// Defines UI colors, icons, onboarding steps text and images, and storage key for onboarding state persistence
enum Onboarding {
    static let cardColor: Color = .gray.opacity(0.6)
    static let icon: String = "xmark.app"
    static let data: [OnboardingStep] = [
        OnboardingStep(
            text: "Tap the screen to place the staircase on the marker",
            systemImageName: "hand.tap"
        ),
        OnboardingStep(
            text: "Move the staircase with your finger",
            systemImageName: "arrow.up.and.down.and.arrow.left.and.right"
        ),
        OnboardingStep(
            text: "Scale the staircase with two fingers",
            systemImageName: "arrow.up.left.and.down.right.magnifyingglass"
        ),
        OnboardingStep(
            text: "Rotate the staircase with a rotation gesture",
            systemImageName: "rotate.3d"
        )
    ]
    static let storageKey: String = "onboarding"
}

/// Contains the names of USDZ files included in the app bundle
/// Used to populate the model selection list in `SelectARModelView`
enum BundleUSDZFiles {
    static let stairs = "stairs"
    static let robot = "robot"
    static let objects: [String] = [
        stairs,
        robot
    ]
}

/// UI constants used in `SelectARModelView`
/// Strings are localized to support future expansion into multiple languages
enum  SelectARModels {
    static let title = LocalizedStringKey("App ARModelViewer")
    static let titleFirstSection = LocalizedStringKey("Bundle models")
    static let titleSecondSection = LocalizedStringKey("Load models from FileManager")
    static let buttonTitle = LocalizedStringKey("Load file")
}
