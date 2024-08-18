//
//  ForgotPasswordViewModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import Foundation
import FirebaseAuth

enum ForgotPasswordState {
    case initial
    case submitting
    case succeeded
    case failed
}

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    @Published private(set) var forgotPasswordState = ForgotPasswordState.initial
    @Published private(set) var errorMessage = ""

    func requestEmail(_ email: String) async {
        forgotPasswordState = .submitting

        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            forgotPasswordState = .succeeded
        } catch {
            errorMessage = error.localizedDescription
            forgotPasswordState = .failed
        }
    }
}
