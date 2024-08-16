//
//  PasswordField.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct PasswordField: View {

    @ObservedObject var password: Password

    var body: some View {
        VStack{
            SecureField(LocalizedStrings.password, text: $password.value)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(password.isValid ? .gray.opacity(0.2) : .red, lineWidth: 2))
                .padding(.horizontal, 16)
                .onSubmit {
                    password.submitted()
                }

            if !password.isValid {
                Text(password.error)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.red)
                    .padding(.horizontal, 16)
            }
        }
    }
}

