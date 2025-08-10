//
//  DocumentPikcer.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 05.08.2025.
//

import SwiftUI
import UniformTypeIdentifiers

/// SwiftUI wrapper for UIDocumentPickerViewController
/// using the UIViewControllerRepresentable protocol
struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var usdzDocumentURL: URL?

    func makeCoordinator() -> Coordinator {
        Coordinator(usdzDocumentURL: $usdzDocumentURL)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let types = [UTType.usdz]
        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: types,
            asCopy: true
        )
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Binding var usdzDocumentURL: URL?

        init(usdzDocumentURL: Binding<URL?>) {
            self._usdzDocumentURL = usdzDocumentURL
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            usdzDocumentURL = urls.first
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            usdzDocumentURL = nil
        }
    }
}
