//
//  DrawingView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI

struct DrawingView: View {

    @EnvironmentObject var viewModel: DrawingViewModel

    var body: some View {
        ZStack {
            if let image = UIImage(data: viewModel.imageData) {
                let screenWidth = UIScreen.main.bounds.width
                let aspectRatio = image.size.height / image.size.width
                let calculatedHeight = screenWidth * aspectRatio
                let size = CGSize(width: screenWidth, height: calculatedHeight)

                CanvasView(canvas: $viewModel.canvas, imageData: $viewModel.imageData, toolPicker: $viewModel.toolPicker, rect: size)
                    .background(Color.red)
                    .frame(width: size.width, height: size.height)
                    .onAppear() {
                        DispatchQueue.main.async {
                            viewModel.size = size
                        }
                    }
            }
            ForEach(viewModel.textBoxes) { box in
                Text(viewModel.textBoxes[viewModel.currentIndex].id == box.id && viewModel.addNewBox ? "" : box.text)
                    .font(.system(size: 30))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundStyle(box.textColor)
                    .offset(box.offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        let current = value.translation
                        let lastOffset = box.lastOffset
                        let newTranslation = CGSize(width: lastOffset.width + current.width, height: lastOffset.height + current.height)
                        viewModel.textBoxes[getIndex(textBox: box)].offset = newTranslation
                    }).onEnded({ (value) in
                        viewModel.textBoxes[getIndex(textBox: box)].lastOffset = value.translation
                    }))
                    .onLongPressGesture() {
                        viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.resignFirstResponder()
                        viewModel.currentIndex = getIndex(textBox: box)
                        withAnimation {
                            viewModel.addNewBox = true
                        }
                    }
            }
        }
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.saveImage()
                }, label: {
                    Text(LocalizedStrings.save)
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.textBoxes.append(TextBox())
                    viewModel.currentIndex = viewModel.textBoxes.count - 1
                    withAnimation {
                        viewModel.addNewBox.toggle()
                    }
                    viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                    viewModel.canvas.resignFirstResponder()
                }, label: {
                    Image(systemName: "plus")
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.showFilterSheet.toggle()
                }, label: {
                    Image(systemName: "wand.and.stars")
                })
                .sheet(isPresented: $viewModel.showFilterSheet) {
                    FilterSelectionView(selectedFilter: $viewModel.selectedFilter, showFilterSheet: $viewModel.showFilterSheet)
                }
            }
        }
    }

    func getIndex(textBox: TextBox) -> Int {
        let index = viewModel.textBoxes.firstIndex { (box) -> Bool in
            return textBox.id == box.id
        } ?? 0

        return index
    }
}

#Preview {
    EditorView()
}
