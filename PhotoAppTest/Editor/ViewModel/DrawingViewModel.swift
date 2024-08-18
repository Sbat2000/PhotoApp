//
//  DrawingViewModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import Foundation
import PencilKit

final class DrawingViewModel: ObservableObject {

    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()

    func cancelImageEditing() {
        imageData = Data(count: 0)
        canvas = PKCanvasView()
    }
}
