//
//  Extension+URL.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import Foundation

/// Returns the filename without its extension
extension URL {
    var usdzFileNameWithoutExtension: String {
        self.deletingPathExtension().lastPathComponent
    }
}
