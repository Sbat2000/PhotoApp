//
//  AuthButton.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct AuthButton: View {

    @Binding var showAlert: Bool
    var buttonTitle: LocalizedStringKey
    var backgroundColor: Color
    var alertError: String
    var onTap: () -> ()

    var body: some View {
        Button(action: onTap) {
            Text(buttonTitle)
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, minHeight: 55)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(Color.white)
                .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Failed"),
                  message: Text(alertError),
                  dismissButton: .default(Text(LocalizedStrings.alertOkButton))
            )
        }
    }
}
