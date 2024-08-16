//
//  Authentication.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct AuthenticationView: View {

    @State private var signUp: Bool = true

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.1).ignoresSafeArea()

            SignUpView()

            VStack{
                Spacer()
                Text(signUp ? LocalizedStrings.alreadyHaveAccount : LocalizedStrings.dontHaveAnAccount)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.blue)
                    .padding()
                    .onTapGesture {
                        signUp.toggle()
                    }
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
