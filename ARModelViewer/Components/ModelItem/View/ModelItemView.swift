//
//  ModelListItemView.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import SwiftUI

struct ModelItemView: View {
    @StateObject private var viewModel: ModelItemViewModel
    let model: USDZFile
    init(model: USDZFile) {
        self.model = model
        _viewModel = StateObject(wrappedValue: ModelItemViewModel())
    }
    var body: some View {
        HStack{
            Text(model.name.uppercased())
            Spacer()
            imageThumbnail
        }
        .task(id: model.id) {
            await viewModel.getImage(url: model.url)
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
