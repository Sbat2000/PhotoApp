//
//  SignUpView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct SignUpView: View {

    @State private var showAlert = false

    @StateObject private var email = Email()
    @StateObject private var password = Password()

    var body: some View {
        VStack {
            TitleView(text: LocalizedStrings.createAccount)
            EmailField(email: email)
                .padding(.bottom, 16)
            
            PasswordField(password: password)

            AuthButton(
                showAlert: $showAlert,
                buttonTitle: LocalizedStrings.signUpButtonTitle,
                backgroundColor: .yellow.opacity(0.9),
                alertError: LocalizedStrings.error) {
                    
                }
        }
        .padding(.bottom, 55)
    }
}
