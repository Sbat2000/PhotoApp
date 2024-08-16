//
//  FormValidation.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 16.08.2024.
//

import SwiftUI

fileprivate protocol FormValidation {
    var isValid: Bool { get }
    var value: String { get set }
    var error: LocalizedStringKey { get }
    var isSubmitted: Bool { get }
    func submitted()
}

final class Email: FormValidation, ObservableObject {
    @Published private(set) var isValid: Bool = true

    @Published var value: String = ""

    @Published private(set) var error: LocalizedStringKey = ""

    @Published fileprivate var isSubmitted: Bool = false

    init() {
        $value.combineLatest($isSubmitted)
            .map { email, isSubmitted in
                if !isSubmitted {
                    return true
                }

                if email.isEmpty {
                    self.error = LocalizedStrings.emptyEmailError
                    return false
                } else if self.validateEmail(email) {
                    return true
                } else {
                    self.error = LocalizedStrings.invalidEmailError
                    return false
                }
            }.assign(to: &$isValid)
    }

    func submitted() {
        isSubmitted = true
    }

    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let regex = try! NSRegularExpression(pattern: emailRegex, options: [.caseInsensitive])
        return regex.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) != nil
    }
}
