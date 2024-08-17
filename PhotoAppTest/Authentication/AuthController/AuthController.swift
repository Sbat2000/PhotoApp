//
//  AuthController.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import Foundation
import FirebaseAuth

enum AuthState {
    case authenticated
    case unauthenticated
}

final class AuthController: ObservableObject {
    @Published private(set) var authState = AuthState.unauthenticated
    @Published private(set) var authUser = AuthUserModel.empty

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            if let user {
                guard let email = user.email else { return }
                self.authUser = AuthUserModel(id: user.uid, email: email)
                self.authState = .authenticated
            } else {
                self.authState = .unauthenticated
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
