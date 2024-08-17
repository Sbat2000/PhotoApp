//
//  GoogleAuthButton.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct GoogleAuthButton: View {
    var body: some View {
        HStack {
            Image(.google)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)

            Text(LocalizedStrings.signInWithGoogle)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.black.opacity(0.5))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .containerShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

#Preview {
    GoogleAuthButton()
}
