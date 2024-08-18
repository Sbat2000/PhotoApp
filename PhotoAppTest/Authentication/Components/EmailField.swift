//
//  EmailField.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct EmailField: View {

    @ObservedObject var email: Email

    var body: some View {
        VStack{
            TextField(LocalizedStrings.email, text: $email.value)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(email.isValid ? .gray.opacity(0.2) : .red, lineWidth: 2))
                .padding(.horizontal, 16)
                .onSubmit {
                    email.submitted()
                }
            
            if !email.isValid {
                Text(email.error)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.red)
                    .padding(.horizontal, 16)
            }
        }
    }
}

