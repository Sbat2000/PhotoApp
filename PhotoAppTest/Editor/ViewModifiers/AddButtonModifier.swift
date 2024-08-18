//
//  AddButton.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI

struct AddButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.black)
            .frame(width: 70, height: 70)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: -5)
    }
}
