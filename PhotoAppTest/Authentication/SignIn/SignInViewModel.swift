//
//  SignInViewModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import Foundation
import FirebaseAuth

enum SignInState {
    case initial
    case submitting
    case succeeded
    case failed
}

@MainActor
final class SignInViewModel: ObservableObject {
    @Published private(set) var signInState = SignInState.initial
    @Published private(set) var errorMessage = ""

    func signIn(_ email: String, _ password: String) async {
        let newEmail = email.lowercased()
        signInState = .submitting

        do {
            try await Auth.auth().signIn(withEmail: newEmail, password: password)
            signInState = .succeeded
        } catch {
            errorMessage = error.localizedDescription
            signInState = .failed
        }
    }
}
