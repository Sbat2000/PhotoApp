//
//  EditorView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI

struct EditorView: View {

    @StateObject var viewModel = DrawingViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let imageFile = UIImage(data: viewModel.imageData) {
                    DrawingView()
                        .environmentObject(viewModel)
                        .toolbar() {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    viewModel.cancelImageEditing()
                                } label: {
                                    Image(systemName: "xmark")
                                }
                            }
                        }
                } else {
                    Button {
                        viewModel.showImagePicker.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .modifier(AddButtonModifier())

                }
            }
            .navigationTitle(LocalizedStrings.imageEditor)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(showPicker: $viewModel.showImagePicker, imageData: $viewModel.imageData)
        }
    }
}

#Preview {
    EditorView()
}
