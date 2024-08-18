//
//  AuthenticationFlow.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct AuthenticationFlow: View {

    @StateObject private var authController = AuthController()

    var body: some View {

        Group {
            if authController.authState == .authenticated {
                EditorView()
            } else {
                AuthenticationView()
            }
        }.environmentObject(authController)
    }
}

#Preview {
    AuthenticationFlow()
}
