//
//  ARModelViewApp.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import SwiftUI

@main
struct ARModelViewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SelectARModelView()
        }
    }
}
