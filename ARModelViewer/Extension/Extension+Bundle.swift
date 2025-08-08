//
//  Extension+Bundle.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import Foundation

extension Bundle {
    func usdzURL(_ filename: String) -> URL? {
        url(forResource: filename, withExtension: "usdz")
    }
}
