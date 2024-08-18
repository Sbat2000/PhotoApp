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
                            viewModel.showImagePicker.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .modifier(AddButtonModifier())

                    }
                }
                .navigationTitle(LocalizedStrings.imageEditor)
            }

            if viewModel.addNewBox {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()

                TextField(LocalizedStrings.typeHere, text: $viewModel.textBoxes[viewModel.currentIndex].text)
                    .font(.system(size: 35))
                    .preferredColorScheme(.dark)
                    .foregroundStyle(viewModel.textBoxes[viewModel.currentIndex].textColor)
                    .padding()
                HStack {
                    Button {
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
                    ColorPicker("", selection: $viewModel.textBoxes[viewModel.currentIndex].textColor)
                        .labelsHidden()
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(showPicker: $viewModel.showImagePicker, imageData: $viewModel.imageData)
        }
    }
}

#Preview {
    EditorView()
}
