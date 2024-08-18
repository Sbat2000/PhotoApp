//
//  HomeView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject private var authController: AuthController

    var body: some View {
        VStack {
            Text("Your email: \(authController.authUser.email)")
            Button("Sign Out") {
                authController.signOut()
            }
        }
    }
}
