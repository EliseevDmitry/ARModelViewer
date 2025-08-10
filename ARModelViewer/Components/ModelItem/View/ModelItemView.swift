//
//  ModelListItemView.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import SwiftUI

/// A list item view that displays information about a 3D model
/// Includes the model's name and its thumbnail generated using QuickLookThumbnailing
struct ModelItemView: View {
    let model: USDZFile
    @StateObject
    private var viewModel = ModelItemViewModel()
    var body: some View {
        HStack{
            Text(model.name.uppercased())
            Spacer()
            imageThumbnail
        }
        .task(id: model.url) {
            do {
                try await viewModel.getImageAndName(url: model.url)
            } catch {
                print(error)
            }
        }
    }
    
    private var imageThumbnail: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.clear
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    if let url = Bundle.main.usdzURL(BundleUSDZFiles.robot){
        let model = USDZFile(name: BundleUSDZFiles.robot, url: url)
        ModelItemView(model: model)
    }
}
