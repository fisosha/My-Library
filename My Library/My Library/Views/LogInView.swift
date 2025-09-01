//
// SignUpView.swift
// MyLibrary
//
// Created by Софія Шаламай on 17.08.2025.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    @StateObject private var viewModel = LogInViewModel()
    var body: some View {
        VStack(spacing: 0) {
            
            // HEADER
            Color.logInGray
                .frame(height: 400)
                .ignoresSafeArea(edges: .top)
                .overlay(
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back")
                            .font(.custom("LibreBaskerville-Regular", size: 42))
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                        
                        Text("Continue your reading journey and keep your library up to date.")
                            .font(.custom("LibreBaskerville-Regular", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.trailing, 85)
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
            
            // FORM
            ScrollView {
                VStack(spacing: 15) {
                    CustomTextField(placeholder: "Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding(.top, 2)
                    
                    SecureCustomTextField(placeholder: "Password", text: $viewModel.password)
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.top, 4)
                    }
                    
                    Button {
                        viewModel.logIn()
                    } label: {
                        Text("Log in")
                            .font(.custom("LibreBaskerville-Regular", size: 14))
                            .frame(width: 333, height: 47)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(25.5)
                    }
                    .padding(.top, 6)
                    
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .opacity(0.6)
                        
                        NavigationLink("Sign up") {
                            SignUpView()
                        }
                        .foregroundColor(.orange)
                        .bold()
                    }
                    .font(.system(size: 12))
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isLoggedIn) {
            AppTabsView()
        }
    }
}

extension Color {
    static let logInGray = Color(red: 50/255, green: 62/255, blue: 76/255)
}

#Preview {
    LogInView()
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .frame(width: 333, height: 47)
    }
}

struct SecureCustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .frame(width: 333, height: 47)
    }
}
