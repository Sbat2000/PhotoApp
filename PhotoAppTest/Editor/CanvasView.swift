//
//  CanvasView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {

    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker

    var rect: CGSize

    func makeUIView(context: Context) -> PKCanvasView {

        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput


        if let image = UIImage(data: imageData) {
            let aspectRatio = image.size.height / image.size.width
            let calculatedHeight = rect.width * aspectRatio
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: calculatedHeight)
            imageView.clipsToBounds = true

            canvas.frame = CGRect(x: 0, y: 0, width: rect.width, height: calculatedHeight)

            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)

            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
        return canvas
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
