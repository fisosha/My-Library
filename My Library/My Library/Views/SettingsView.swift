//
// SettingsView.swift
// MyLibrary
//
// Created by Софія Шаламай on 20.08.2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    var onLogOut: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Settings")
                    .font(.custom("LibreBaskerville-Regular", size: 34))
                Spacer()
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "person.fill")
                            .imageScale(.small))
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            
            HStack(spacing: 12) {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2))
                    .background(
                        Circle()
                            .fill(Color(.systemGray5)))
                VStack(alignment: .leading, spacing: 4) {
                    Text(vm.name)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text(vm.email)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    // ще поки не готово(
                } label: {
                    Image(systemName: "pencil")
                        .imageScale(.medium)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            if let err = vm.error {
                Text(err)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .padding(.top, 6)
            }
            
            Button {
                vm.logOut()
            } label: {
                Text("Log Out")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .foregroundStyle(.white) .background(Color.orange)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            
            Spacer()
            
            Image("Settings")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 420)
                .padding(.bottom, 20)
        }
        .onChange(of: vm.didLogOut) { _, loggedOut in
            if loggedOut {
                onLogOut?()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView(onLogOut: {})
}
