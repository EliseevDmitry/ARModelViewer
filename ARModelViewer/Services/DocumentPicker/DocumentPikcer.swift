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
            asCopy: false
        )
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Binding var usdzDocumentURL: URL?

        init(usdzDocumentURL: Binding<URL?>) {
            self._usdzDocumentURL = usdzDocumentURL
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else {
                print("No URL was picked")
                return
            }
            let canAccess = url.startAccessingSecurityScopedResource()
            guard canAccess else {
                print("Failed to start accessing security scoped resource")
                return
            }
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            
            do {
                let newURL = try copyFileToDocumentsWithUUID(from: url)
                usdzDocumentURL = newURL
            } catch {
                print("Copy error: \(error.localizedDescription)")
            }
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            usdzDocumentURL = nil
        }

        /// Copies the file from the source URL into a unique UUID folder inside the Documents directory.
        /// This is necessary to obtain a local copy of the file without the restrictions and protections
        /// imposed by UIDocumentPickerViewController when accessing the file directly.
        /// In our case, the copy is needed for further file processing, such as generating a thumbnail using QuickLookThumbnailing.
        /// Without creating a copy, QuickLook will not be able to process the file correctly.
        private func copyFileToDocumentsWithUUID(from sourceURL: URL) throws -> URL {
            let fileManager = FileManager.default
            guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                throw URLError(.badURL)
            }
            let uuidFolderURL = documentsURL.appendingPathComponent(UUID().uuidString, isDirectory: true)
            if !fileManager.fileExists(atPath: uuidFolderURL.path) {
                try fileManager.createDirectory(at: uuidFolderURL, withIntermediateDirectories: true)
            }
            let fileName = sourceURL.usdzFileNameWithoutExtension
            let newFileName = "\(fileName).usdz"
            let destinationURL = uuidFolderURL.appendingPathComponent(newFileName)
            try fileManager.copyItem(at: sourceURL, to: destinationURL)
            return destinationURL
        }
    }
}
