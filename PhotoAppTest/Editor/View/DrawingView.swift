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
            GeometryReader { proxy -> AnyView in
                let size = proxy.frame(in: .global).size

                let size = proxy.frame(in: .local).size
                return AnyView (
                    CanvasView(canvas: $viewModel.canvas, imageData: $viewModel.imageData, toolPicker: $viewModel.toolPicker, rect: size)
                        .background(Color.yellow)
                )
            }
        }
    }
}

#Preview {
    EditorView()
}
