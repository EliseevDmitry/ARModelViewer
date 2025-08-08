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
    
    init() {
        setupBindings()
    }
    
    func setupBindings(){
        $usdzURL
            .compactMap { $0 }
            .sink { [weak self] url in
                guard let self else { return }
                self.model = self.getModelFromURL(url: url)
            }
            .store(in: &cancellables)
    }
}

extension ARModelSelectionViewModel{
    //pub
    func getUSDZFileWithURL(item: String) -> USDZFile? {
        guard let url = getURLFromBundle(filename: item) else { return nil }
        return USDZFile(name: item, url: url)
    }
}


extension ARModelSelectionViewModel {
    //Ex
    private func getURLFromBundle(filename: String) -> URL? {
        Bundle.main.usdzURL(filename)
    }
    
    //usdzFileNameWithoutExtension Ex
    private func getModelFromURL(url: URL) -> USDZFile {
        let fileName = url.usdzFileNameWithoutExtension
        return USDZFile(name: fileName, url: url)
    }
}
