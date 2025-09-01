//
// SignUpView.swift
// MyLibrary
//
// Created by Софія Шаламай on 17.08.2025.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.signupGreen
                    .frame(height: 400)
                    .ignoresSafeArea(edges: .top)
                    .overlay(
                        VStack {
                            Text("Create Your Account")
                                .font(.custom("LibreBaskerville-Regular", size: 42))
                                .padding(.leading, 30)
                                .padding(.trailing, 110)
                                .padding(.bottom, 15)
                                .foregroundColor(.white)
                            
                            Text("Start tracking your books and reading \nprogress today.")
                                .font(.custom("LibreBaskerville-Regular", size: 14))
                                .padding(.leading, 30)
                                .padding(.trailing, 85)
                                .foregroundColor(.white)
                        }
                    )
                
                VStack {
                    Color.white
                        .overlay(
                            VStack {
                                CustomTextField(placeholder: "Full name", text: $viewModel.fullName)
                                    .presentationCornerRadius(25)
                                    .padding(.bottom, 15)
                                
                                CustomTextField(placeholder: "Email", text: $viewModel.email)
                                    .padding(.bottom, 15)
                                
                                SecureCustomTextField(placeholder: "Password", text: $viewModel.password)
                                    .textContentType(.newPassword) // або .oneTimeCode щоб вимкнути
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .padding(.bottom, 15)
                                
                                SecureCustomTextField(placeholder: "Confirm password", text: $viewModel.confirmPassword)
                                    .textContentType(.newPassword) // або .oneTimeCode щоб вимкнути
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .padding(.bottom, 15)
                                
                                Button {
                                    viewModel.signUp()
                                } label: {
                                    Text("Sign up")
                                        .font(.custom("LibreBaskerville-Regular", size: 14))
                                        .frame(width: 333, height: 47)
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                        .cornerRadius(25.5)
                                }
                                
                                if let error = viewModel.errorMessage {
                                    Text(error)
                                        .foregroundColor(.red)
                                        .font(.footnote)
                                        .padding(.top, 4)
                                }
                                
                                HStack {
                                    Text("Already have an account?")
                                        .opacity(0.6)
                                    
                                    NavigationLink {
                                        LogInView()
                                    } label: {
                                        Text("Log in")
                                            .foregroundColor(.orange)
                                            .bold()
                                    }
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 40)
                                .font(.system(size: 12))
                            }
                        )
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.isSignedUp) {
                    AppTabsView()
                }
    }
}

extension Color {
    static let signupGreen = Color(red: 71/255, green: 148/255, blue: 130/255)
}
#Preview {
    SignUpView()
}
