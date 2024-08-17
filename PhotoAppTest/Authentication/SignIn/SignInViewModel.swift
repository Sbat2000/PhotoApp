//
//  SignInViewModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

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

    func signInWithGoogle() async {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

        do {
            signInState = .submitting
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

            guard let idToken = result.user.idToken?.tokenString else { return }
            let accessToken = result.user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            try await Auth.auth().signIn(with: credential)

            signInState = .succeeded
        } catch {
            signInState = .failed
            errorMessage = error.localizedDescription
        }
    }
}
