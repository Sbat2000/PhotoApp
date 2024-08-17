//
//  AuthUserModel.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import Foundation

struct AuthUserModel {
    let id: String
    let email: String

    static let empty = AuthUserModel(id: "", email: "")
}
