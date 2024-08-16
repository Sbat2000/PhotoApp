//
//  SignUpView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct SignUpView: View {

    @StateObject private var email = Email()
    @StateObject private var password = Password()

    var body: some View {
        VStack {
            TitleView(text: LocalizedStrings.createAccount)
            EmailField(email: email)
                .padding(.bottom, 16)
            
            PasswordField(password: password)
        }
        .padding(.bottom, 55)
    }
}
