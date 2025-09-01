//
// OnboardingView.swift
// MyLibrary
//
// Created by Софія Шаламай on 17.08.2025.
//

import SwiftUI
import Foundation

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("Books")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 333, height: 238)
                    .padding(.top, 125)
                
                VStack {
                    Text("Track Your \nBooks And Plan What’s Next")
                        .font(.custom("LibreBaskerville-Regular", size: 42))
                        .padding(.top, 15)
                        .padding(.horizontal, 18)
                        .lineLimit(nil)
                    
                    Text("Track what you’ve read, what you’re reading, and what’s next.")
                        .font(.custom("LibreBaskerville-Regular", size: 14))
                        .padding(.top, 5)
                        .padding(.leading, 30)
                        .padding(.trailing, 115)
                }
                
                VStack {
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up")
                            .font(.custom("LibreBaskerville-Regular", size: 14))
                            .frame(width: 333, height: 47)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(25.5)
                            .padding(.top, 15)
                    }
                    .background(Color.white)
                    
                    NavigationLink {
                        LogInView()
                    } label: {
                        Text("Log in")
                            .font(.custom("LibreBaskerville-Regular", size: 14))
                            .frame(width: 333, height: 47)
                            .foregroundColor(.black)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(25.5)
                            .padding(.top, 5)
                    }
                    .background(Color.white)
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
