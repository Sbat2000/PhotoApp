//
//  DrawingViewModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI
import PencilKit

final class DrawingViewModel: ObservableObject {

    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()

    @Published var textBoxes : [TextBox] = []

    @Published var addNewBox = false

    @Published var currentIndex: Int = 0

    func cancelImageEditing() {
        imageData = Data(count: 0)
        canvas = PKCanvasView()
    }

    func cancelTextView() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        withAnimation {
            addNewBox = false
        }
        textBoxes.removeLast()
    }
}
