//
//  Storage.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import Foundation

protocol IStorageService {
    func setKey(key: String)
    func getKey(key: String) -> Bool
}

/// Storage service for DI and testing
final class Storage: IStorageService {
    private var storage: UserDefaults = .standard
}

// MARK: - Public Functions
extension Storage {
    func setKey(key: String) {
        storage.set(true, forKey: key)
    }
    
    func getKey(key: String) -> Bool {
        storage.bool(forKey: key)
    }
}
