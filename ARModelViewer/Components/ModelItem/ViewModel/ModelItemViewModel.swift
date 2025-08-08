//
//  ModelItemViewModel.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import SwiftUI

final class ModelItemViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var generator: IThumbnailGenerator
    
    init(generator: IThumbnailGenerator = ThumbnailGenerator()) {
        self.generator = generator
    }
}

// MARK: - Public Functions
extension ModelItemViewModel {
    @MainActor
    func getImage(url: URL, size: CGSize = CGSize(width: 100, height: 100)) async {
        do {
            let image = try await generator.generate(for: url, size: size)
            self.image = image
        } catch {
            print(error)
        }
    }
}
