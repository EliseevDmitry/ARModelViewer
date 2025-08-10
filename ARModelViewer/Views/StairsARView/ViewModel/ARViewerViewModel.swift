//
//  StairsARViewModel.swift
//  TestAugmentedRealityView
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import Foundation
import RealityKit

final class ARViewerViewModel: ObservableObject {
    @Published var modelEntity: ModelEntity? = nil
    private let modelURL: URL
    init(url: URL){
        self.modelURL = url
    }
    
    /// Simulates loading a 3D model from a network or remote source with a delay
    @MainActor
    func getEntity() async {
        do {
            try await Task.sleep(nanoseconds: 4 * 1_000_000_000)
            let entity = try await  ModelEntity(contentsOf: modelURL)//ModelEntity(named: modelName)
            self.modelEntity = entity
        } catch {
            print("Ошибка загрузки модели: \(error)")
        }
    } 
}
