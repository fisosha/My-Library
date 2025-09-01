//
//  My_LibraryApp.swift
//  My Library
//
//  Created by Софія Шаламай on 27.08.2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct My_LibraryApp: App {
    
    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        Task {
            await BookRepository.shared.switchUser(to: Auth.auth().currentUser?.uid)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
