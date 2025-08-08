//
//  Extension+URL.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import Foundation

extension URL {
    var usdzFileNameWithoutExtension: String {
        self.deletingPathExtension().lastPathComponent
    }
}
