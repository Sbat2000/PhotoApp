//
//  HomeView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var authController: AuthController

    var body: some View {
        VStack {
            Text("userID: \(authController.authUser.id)")
            Text("user email: \(authController.authUser.email)")
            Button("Sign Out") {
                authController.signOut()
            }
        }
    }
}
