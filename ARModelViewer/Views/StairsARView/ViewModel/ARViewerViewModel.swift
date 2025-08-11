//
//  StairsARViewModel.swift
//  TestAugmentedRealityView
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import Foundation
import RealityKit

/// ViewModel for loading and storing a 3D model from a URL for AR viewing
final class ARViewerViewModel: ObservableObject {
    @Published var modelEntity: ModelEntity? = nil
    private let modelURL: URL
    
    // MARK: - Initialization
    init(url: URL){
        self.modelURL = url
    }
}

// MARK: - Public Functions
extension ARViewerViewModel {
    /// Asynchronously loads a 3D model from modelURL with a delay to simulate network loading
    /// Upon successful loading, updates modelEntity for UI display
    @MainActor
    func getEntity() async {
        do {
            try await Task.sleep(nanoseconds: 4 * 1_000_000_000)
            let entity = try await  ModelEntity(contentsOf: modelURL)
            self.modelEntity = entity
        } catch {
            print("Model loading error: \(error)")
        }
    }
}
