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
    @StateObject private var signUpViewModel = SignUpViewModel()

    var body: some View {
        VStack {
            TitleView(text: LocalizedStrings.createAccount)
            EmailField(email: email)
                .padding(.bottom, 16)
            
            PasswordField(password: password)

            AuthButton(
                showAlert: $showAlert,
                buttonTitle: signUpViewModel.signUpState == .submitting ?  LocalizedStrings.loading : LocalizedStrings.signUpButtonTitle,
                backgroundColor: signUpViewModel.signUpState == .submitting ? .gray : .yellow.opacity(0.9),
                alertError: signUpViewModel.errorMessage) {
                    if signUpViewModel.signUpState == .initial || signUpViewModel.signUpState == .failed {
                        email.submitted()
                        password.submitted()

                        guard password.isValid && email.isValid else {
                            return
                        }

                        let email = email.value
                        let password = password.value

                        Task {
                            await signUpViewModel.signUp(email, password)
                            showAlert = signUpViewModel.signUpState == .failed
                        }
                    }
                }
        }
        .padding(.bottom, 55)
    }
}
