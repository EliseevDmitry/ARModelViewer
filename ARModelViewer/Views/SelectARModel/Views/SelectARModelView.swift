//
//  SelectARModelView.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 21.07.2025.
//

import SwiftUI

struct SelectARModelView: View {
    @StateObject
    private var viewModel = ARModelSelectionViewModel()
    @State
    private var isShow = false
    var body: some View {
        NavigationStack {
            List {
                bundleModels
                fileManagerModels
            }
            .listStyle(.insetGrouped)
            .navigationTitle(SelectARModels.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var bundleModels: some View {
        Section(SelectARModels.titleFirstSection) {
                ForEach(
                    BundleUSDZFiles.objects.compactMap(viewModel.getUSDZFileWithURL),
                    id: \.url
                ) { model in
                    NavigationLink {
                        ARModelViewer(url: model.url)
                    } label: {
                        ModelItemView(model: model)
                    }
                
            }
        }
    }
    
    private var fileManagerModels: some View {
        Section(SelectARModels.titleSecondSection) {
            HStack(alignment: .center){
                Button(SelectARModels.buttonTitle) {
                    isShow.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.vertical, 2)
            }
            .frame(maxWidth: .infinity)
            .sheet(isPresented: $isShow) {
                DocumentPicker(usdzDocumentURL: $viewModel.usdzURL)
            }
            if let model = viewModel.model {
                NavigationLink {
                    ARModelViewer(url: model.url)
                } label: {
                    ModelItemView(model: model)
                }
            }
        }
    }
}

#Preview {
    SelectARModelView()
}
