//
//  AppConstants.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import SwiftUI

// Configuration constants for the StartPoint entity
struct StartPointConstants {
    static let planeWidth: Float = 0.1
    static let planeDepth: Float = 0.1
    static let cornerRadius: Float = 0.02
    static let colorAlphaComponent = 0.5
    static let startPointColor = UIColor.green
}

//ARService
enum Constants {
    static let minScaleFactor: Float = 0.25
    static let maxScaleFactor: Float = 3.5
    static let panSensitivity: Float = 0.001
    static let focusUpdateInterval: TimeInterval = 0.1
}

//AROnboardingView
enum Onboarding {
    static let cardColor: Color = .gray.opacity(0.6)
    static let icon: String = "xmark.app"
    static let data: [OnboardingStep] = [
        OnboardingStep(text: "Коснитесь экрана, чтобы установить лестницу на маркер", systemImageName: "hand.tap"),
        OnboardingStep(text: "Перемещайте лестницу движением пальца", systemImageName: "arrow.up.and.down.and.arrow.left.and.right"),
        OnboardingStep(text: "Масштабируйте лестницу двумя пальцами", systemImageName: "arrow.up.left.and.down.right.magnifyingglass"),
        OnboardingStep(text: "Поверните лестницу жестом вращения", systemImageName: "rotate.3d")
    ]
    static let storageKey: String = "onboarding"
}

//
enum BundleUSDZFiles {
    static let stairs = "stairs"
    static let robot = "robot"
    static let objects: [String] = [
        stairs,
        robot
    ]
}

enum  SelectARModels {
    static let title = LocalizedStringKey("App ARModelViewer")
    static let titleFirstSection = LocalizedStringKey("Bundle models")
    static let titleSecondSection = LocalizedStringKey("Load models from FileManager")
    static let buttonTitle = LocalizedStringKey("Load file")
}
