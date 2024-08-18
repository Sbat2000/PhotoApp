//
//  SignUpViewModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import Foundation
import FirebaseAuth

enum SignUpState {
    case initial
    case submitting
    case succeeded
    case failed
}

@MainActor
final class SignUpViewModel: ObservableObject {

    @Published private(set) var signUpState = SignUpState.initial
    @Published private(set) var errorMessage = ""

    func signUp(_ email: String, _ password: String) async {
        let newEmail = email.lowercased()
        signUpState = .submitting

        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: newEmail, password: password)
            try await authDataResult.user.sendEmailVerification()
            signUpState = .succeeded
        } catch {
            errorMessage = error.localizedDescription
            signUpState = .failed
        }
    }
}
