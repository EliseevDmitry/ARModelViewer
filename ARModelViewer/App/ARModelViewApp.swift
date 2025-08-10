//
//  ARModelViewApp.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import SwiftUI

@main
struct ARModelViewApp: App {
    var body: some Scene {
        WindowGroup {
           SelectARModelView()
            //ARModelViewer(url: Bundle.main.usdzURL("robot")!)
        }
    }
}
