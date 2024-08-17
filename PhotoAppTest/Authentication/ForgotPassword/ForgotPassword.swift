//
//  ForgotPassword.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct ForgotPassword: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {

            }
            .navigationTitle(LocalizedStrings.forgotPassword)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ForgotPassword()
}
