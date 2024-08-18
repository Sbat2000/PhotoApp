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
    @Published var size: CGSize = .zero
    @Published var showAlert = false
    @Published var message: LocalizedStringKey = ""
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var showFilterSheet: Bool = false
    @Published var selectedFilter: CIFilter? = nil
    @Published var currentScale: CGFloat = 1.0

    func cancelImageEditing() {
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }

    func cancelTextView() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        withAnimation {
            addNewBox = false
        }
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()

        }
    }

    func saveImage() {
        guard let generatedImage = generateImage() else { return }

        UIImageWriteToSavedPhotosAlbum(generatedImage, nil, nil, nil)
        self.message = LocalizedStrings.savedSuccessfully
        self.showAlert.toggle()
    }
}

//MARK: - Share methods

extension DrawingViewModel {
    func captureCanvasView() -> UIImage? {
        return generateImage()
    }

    func shareImage() {
        guard let image = captureCanvasView() else { return }

        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)

            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {
                if let popoverController = activityVC.popoverPresentationController {
                    popoverController.sourceView = window
                    popoverController.sourceRect = CGRect(x: window.bounds.width / 2, y: window.bounds.height / 2, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }

                window.rootViewController?.present(activityVC, animated: true, completion: nil)
            }
    }
}

// MARK: - Private methods

private extension DrawingViewModel {
    func generateImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)

        canvas.drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)

        let swiftUIView = ZStack {
            ForEach(textBoxes) { box in
                Text(box.text)
                    .font(.system(size: 30))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundStyle(box.textColor)
                    .offset(box.offset)
            }
        }

        let controller = UIHostingController(rootView: swiftUIView).view!
        controller.frame = CGRect(origin: .zero, size: size)
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        controller.drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)

        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return generatedImage
    }
}
