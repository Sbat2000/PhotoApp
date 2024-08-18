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
    @Binding var selectedFilter: CIFilter?
    @Binding var currentScale: CGFloat

    var rect: CGSize
    class Coordinator {
           var imageView: UIImageView?
       }

       func makeCoordinator() -> Coordinator {
           return Coordinator()
       }

       func makeUIView(context: Context) -> PKCanvasView {
           canvas.isOpaque = false
           canvas.backgroundColor = .clear
           canvas.drawingPolicy = .anyInput

           let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
           canvas.addGestureRecognizer(pinchGesture)

           toolPicker.setVisible(true, forFirstResponder: canvas)
           toolPicker.addObserver(canvas)
           canvas.becomeFirstResponder()

           return canvas
       }

       func updateUIView(_ uiView: PKCanvasView, context: Context) {
           if context.coordinator.imageView == nil {
               let imageView = UIImageView()
               imageView.contentMode = .scaleAspectFit
               imageView.clipsToBounds = true

               uiView.addSubview(imageView)
               uiView.sendSubviewToBack(imageView)

               context.coordinator.imageView = imageView
           }

           if let image = UIImage(data: imageData) {
               let filteredImage = applyFilter(to: image, filter: selectedFilter)

               if let imageView = context.coordinator.imageView {
                   imageView.image = filteredImage
                   let aspectRatio = image.size.height / image.size.width
                   let calculatedHeight = rect.width * aspectRatio
                   imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: calculatedHeight)
                   uiView.frame = CGRect(x: 0, y: 0, width: rect.width, height: calculatedHeight)
                   imageView.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
               }
           }
       }

       func applyFilter(to image: UIImage, filter: CIFilter?) -> UIImage? {
           guard let filter = filter else { return image }
           let context = CIContext()
           guard let ciImage = CIImage(image: image) else { return nil }

           filter.setValue(ciImage, forKey: kCIInputImageKey)

           guard let outputImage = filter.outputImage else {
               return nil
           }

           guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
               return nil
           }

           return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
       }
}

extension CanvasView.Coordinator {
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let imageView = imageView else { return }

        if sender.state == .began || sender.state == .changed {
            let locationInView = sender.location(in: imageView)

            let scale = sender.scale
            imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)

            let newLocationInView = sender.location(in: imageView)
            let translation = CGPoint(
                x: newLocationInView.x - locationInView.x,
                y: newLocationInView.y - locationInView.y
            )
            imageView.transform = imageView.transform.translatedBy(x: translation.x, y: translation.y)

            sender.scale = 1.0
        }
    }
}

#Preview {
    EditorView()
}
