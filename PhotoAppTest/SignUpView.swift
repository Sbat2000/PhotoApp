//
//  SignUpView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

struct SignUpView: View {

    @StateObject private var email = Email()

    var body: some View {
        EmailField(email: email)
    }
}
