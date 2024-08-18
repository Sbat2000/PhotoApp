//
//  ForgotPassword.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct ForgotPassword: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var email = Email()
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                EmailField(email: email)
                AuthButton(
                    showAlert: $showAlert,
                    buttonTitle: LocalizedStrings.resetPassword,
                    backgroundColor: .blue,
                    alertError: viewModel.errorMessage) {
                        if viewModel.forgotPasswordState == .initial || viewModel.forgotPasswordState == .failed {
                            email.submitted()
                            guard email.isValid else {
                                return
                            }
                            Task {
                                await viewModel.requestEmail(email.value)
                                showAlert = viewModel.forgotPasswordState == .failed

                                if viewModel.forgotPasswordState == .succeeded {
                                    dismiss()
                                }
                            }
                        }
                    }
                Spacer()
            }
            .navigationTitle(LocalizedStrings.forgotPassword)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ForgotPassword()
}
