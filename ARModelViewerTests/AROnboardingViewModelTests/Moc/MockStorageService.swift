//
//  MockStorageService.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import Foundation
@testable import ARModelViewer

final class MockStorageService: IStorageService {
    private var storage: [String: Bool] = [:]
}

// MARK: - Public Functions
extension MockStorageService {
    func setKey(key: String) {
        storage[key] = true
    }
    
    func getKey(key: String) -> Bool {
        storage[key] ?? false
    }
}
