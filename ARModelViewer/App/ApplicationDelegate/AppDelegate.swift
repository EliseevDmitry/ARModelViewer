//
//  AppDelegate.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 11.08.2025.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate { }

// MARK: - Public Functions
extension AppDelegate {
    // Called when the app is about to terminate
    func applicationWillTerminate(_ application: UIApplication) {
        clearDocumentsDirectory()
    }
}

// MARK: - Private Functions
extension AppDelegate {
    // Removes all files and folders inside the app's Documents directory
    private func clearDocumentsDirectory() {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        do {
            let contents = try fileManager.contentsOfDirectory(
                at: documentsURL,
                includingPropertiesForKeys: nil,
                options: []
            )
            for url in contents {
                try fileManager.removeItem(at: url)
            }
        } catch {
            print("Failed to clear Documents directory: \(error)")
        }
    }
}
