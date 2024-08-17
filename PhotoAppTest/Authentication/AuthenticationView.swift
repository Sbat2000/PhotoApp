//
//  Authentication.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct AuthenticationView: View {

    @State private var signUp: Bool = false

    private let pageTransition: AnyTransition = .asymmetric(
        insertion: .scale(scale: 0.9).combined(with: .opacity)
            .animation(.interpolatingSpring(stiffness: 180, damping: 12).delay(0.7)),
        removal: .scale(scale: 0.9).combined(with: .opacity).animation(.easeOut(duration: 0.5).delay(0.2))
    )

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.1).ignoresSafeArea()

            if signUp {
                SignUpView()
                    .transition(pageTransition)
            } else {
                SignInView()
                    .transition(pageTransition)
            }

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
