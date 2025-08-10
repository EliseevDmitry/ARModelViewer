//
//  ARModelSelectionViewModel.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import Foundation
import Combine

final class ARModelSelectionViewModel: ObservableObject {
    @Published var usdzURL: URL? = nil
    @Published var model: USDZFile? = nil
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init() {
        setupBindings()
    }
    
    /// Sets up reactive bindings to observe changes in the model URL
    func setupBindings(){
        $usdzURL
            .compactMap { $0 }
            .sink { [weak self] url in
                guard let self else { return }
               let model = self.getModelFromURL(url: url)
                print(model)
                self.model = model
            }
            .store(in: &cancellables)
    }
}

// MARK: - Public Functions
/// Retrieves a USDZFile object by the filename from the main Bundle
/// - Parameter item: The USDZ filename
/// - Returns: USDZFile if the file exists, otherwise nil
extension ARModelSelectionViewModel{
    func getUSDZFileWithURL(item: String) -> USDZFile? {
        guard let url = getURLFromBundle(filename: item) else { return nil }
        return USDZFile(name: item, url: url)
    }
}

// MARK: - Private Functions
extension ARModelSelectionViewModel {
    /// Gets the URL of a USDZ file from the main Bundle by filename
    /// - Parameter filename: The USDZ filename
    /// - Returns: The file URL if found, otherwise nil
    private func getURLFromBundle(filename: String) -> URL? {
        Bundle.main.usdzURL(filename)
    }
    
    //// Constructs a USDZFile instance from a file URL
    /// - Parameter url: The USDZ file URL
    /// - Returns: An instance of USDZFile with name and URL
    private func getModelFromURL(url: URL) -> USDZFile {
        let fileName = url.usdzFileNameWithoutExtension
        return USDZFile(name: fileName, url: url)
    }
}
