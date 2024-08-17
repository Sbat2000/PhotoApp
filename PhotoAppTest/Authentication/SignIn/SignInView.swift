//
//  SignInView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct SignInView: View {

    @State private var showAlert = false
    @State private var showSheet = false

    @StateObject private var email = Email()
    @StateObject private var password = Password()
    @StateObject private var signInViewModel = SignInViewModel()

    var body: some View {
        VStack {
            TitleView(text: LocalizedStrings.welcomeBack)
            EmailField(email: email)
                .padding(.bottom, 16)

            PasswordField(password: password)

            Text(LocalizedStrings.forgotPassword)
                .modifier(ForgotTitleModifier())
                .onTapGesture {
                    showSheet.toggle()
                }

            AuthButton(
                showAlert: $showAlert,
                buttonTitle: signInViewModel.signInState == .submitting ?  LocalizedStrings.loading : LocalizedStrings.signInButtonTitle,
                backgroundColor: signInViewModel.signInState == .submitting ? .gray : .green.opacity(0.9),
                alertError: signInViewModel.errorMessage) {
                    if signInViewModel.signInState == .initial || signInViewModel.signInState == .failed {
                        email.submitted()
                        password.submitted()

                        guard password.isValid && email.isValid else {
                            return
                        }

                        let email = email.value
                        let password = password.value

                        Task {
                            await signInViewModel.signIn(email, password)
                            showAlert = signInViewModel.signInState == .failed
                        }
                    }
                }
            GoogleAuthButton()
                .onTapGesture {
                    
                }
        }
        .padding(.bottom, 55)
        .sheet(isPresented: $showSheet) {
            ForgotPassword()
        }
    }
}

#Preview {
    SignInView()
}
