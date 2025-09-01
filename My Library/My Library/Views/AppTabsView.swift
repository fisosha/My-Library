//
// AppTabsView.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
//
import SwiftUI

struct AppTabsView: View {
    @State private var selected: TabItem = .home
    @State private var showAuth = false
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selected {
                case .home:
                    NavigationStack {
                        HomeView(onGoToSearch: {
                            withAnimation(.easeInOut) {
                                selected = .search
                            }
                        })
                    }
                case .search:
                    NavigationStack {
                        SearchView()
                    }
                case .settings:
                    NavigationStack {
                        SettingsView(onLogOut: {
                            showAuth = true
                        })
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
            BottomBar(selected: selected) {
                newTab in withAnimation(.easeInOut) {
                    selected = newTab
                }
            }
            .fullScreenCover(isPresented: $showAuth) {
                NavigationStack {
                    OnboardingView()
                }
            }
        }
    }
}

#Preview {
    AppTabsView()
}
