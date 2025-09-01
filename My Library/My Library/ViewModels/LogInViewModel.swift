//
// LogInViewModel.swift
// MyLibrary
//
// Created by Софія Шаламай on 18.08.2025.
//

import Foundation
import FirebaseAuth

@MainActor
final class LogInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    func logIn() {
        errorMessage = nil
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        Task {
            do {
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                await BookRepository.shared.switchUser(to: result.user.uid)
                isLoggedIn = true
            }
            catch {
                let ns = error as NSError
                let code = AuthErrorCode(_bridgedNSError: ns)?.code
                errorMessage = {
                    switch code {
                    case .invalidEmail:
                        "Please enter a valid email."
                    case .wrongPassword:
                        "Incorrect password."
                    case .userNotFound:
                        "User not found."
                    case .networkError:
                        "Network error. Try again."
                    case .tooManyRequests:
                        "Too many attempts. Try later."
                    default:
                        ns.localizedDescription
                    }
                }()
            }
        }
    }
    
}
