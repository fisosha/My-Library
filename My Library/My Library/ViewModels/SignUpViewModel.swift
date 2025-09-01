//
// SignUpViewModel.swift
// MyLibrary
//
// Created by Софія Шаламай on 17.08.2025.
//

import SwiftUI
import Foundation
import FirebaseAuth

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isSignedUp = false
    
    func signUp() {
        errorMessage = nil
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        Task {
            isLoading = true
            defer {
                isLoading = false
            }
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                let change = result.user.createProfileChangeRequest()
                change.displayName = fullName
                try await change.commitChanges()
                await BookRepository.shared.switchUser(to: result.user.uid)
                isSignedUp = true
            }
            catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
