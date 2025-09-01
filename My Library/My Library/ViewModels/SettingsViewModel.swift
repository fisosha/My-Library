//
// SettingsViewModel.swift
// MyLibrary
//
// Created by Софія Шаламай on 20.08.2025.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var error: String?
    @Published var isLoading = false
    @Published var didLogOut = false
    init() {
        loadUser()
    }
    func loadUser() {
        let user = Auth.auth().currentUser
        self.name = user?.displayName ?? user?.email?.components(separatedBy: "@").first ?? "User" 
        self.email = user?.email ?? ""
    }
    func logOut() {
        error = nil
        isLoading = true
        do {
            try Auth.auth().signOut()
            didLogOut = true
            
            Task {
                await BookRepository.shared.switchUser(to: nil)
            }
        }
        catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
