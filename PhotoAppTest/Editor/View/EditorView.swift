//
//  EditorView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI

struct EditorView: View {

    @StateObject var viewModel = DrawingViewModel()
    @State private var showActionSheet = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if let _ = UIImage(data: viewModel.imageData) {
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
                            showActionSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .modifier(AddButtonModifier())
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(
                                title: Text(LocalizedStrings.chooseSource),
                                buttons: [
                                    .default(Text(LocalizedStrings.takePhoto)) {
                                        viewModel.sourceType = .camera
                                        viewModel.showImagePicker.toggle()
                                    },
                                    .default(Text(LocalizedStrings.photoLibrary)) {
                                        viewModel.sourceType = .photoLibrary
                                        viewModel.showImagePicker.toggle()
                                    },
                                    .cancel()
                                ]
                            )
                        }

                    }
                }
                .navigationTitle(LocalizedStrings.imageEditor)
            }

            if viewModel.addNewBox {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()

                TextField(LocalizedStrings.typeHere, text: $viewModel.textBoxes[viewModel.currentIndex].text)
                    .font(.system(size: 35, weight: viewModel.textBoxes[viewModel.currentIndex].isBold ? .bold : .regular))
                    .preferredColorScheme(.dark)
                    .foregroundStyle(viewModel.textBoxes[viewModel.currentIndex].textColor)
                    .padding()
                HStack {
                    Button {
                        viewModel.textBoxes[viewModel.currentIndex].isAdded = true
                        viewModel.toolPicker.setVisible(true, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.becomeFirstResponder()
                        withAnimation {
                            viewModel.addNewBox = false
                        }
                    } label: {
                        Text(LocalizedStrings.add)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.white)
                            .padding()
                    }

                    Spacer()

                    Button {
                        viewModel.cancelTextView()
                    } label: {
                        Text(LocalizedStrings.cancel)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.white)
                            .padding()
                    }
                }
                .overlay {
                    HStack(spacing: 15) {
                        ColorPicker("", selection: $viewModel.textBoxes[viewModel.currentIndex].textColor)
                            .labelsHidden()
                        Button {
                            viewModel.textBoxes[viewModel.currentIndex].isBold.toggle()
                        } label: {
                            Text(viewModel.textBoxes[viewModel.currentIndex].isBold ? LocalizedStrings.normal : LocalizedStrings.bold)
                                .foregroundStyle(Color.white)
                        }

                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(showPicker: $viewModel.showImagePicker, imageData: $viewModel.imageData, sourceType: viewModel.sourceType)
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(LocalizedStrings.message), message: Text(viewModel.message), dismissButton: .destructive(Text(LocalizedStrings.ok)))
        })
    }
}

#Preview {
    EditorView()
}
