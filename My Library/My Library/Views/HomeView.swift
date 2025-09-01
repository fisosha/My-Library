//
// HomeView.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
//
import SwiftUI

struct EmptyStateView: View {
    let imageName: String
    let title: String
    let message: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            // картинка-заглушка
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 260)
                .padding(.top, 32)
            
            // заголовок
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .multilineTextAlignment(.center)
            
            // підзаголовок
            Text(message)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .padding(.horizontal, 24)
            
            // кнопка
            Button(action: buttonAction) {
                Text(buttonTitle)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .foregroundStyle(.white)
                    .background(Color.orange)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 24)
            
            Spacer(minLength: 12)
        }
        .padding(.bottom, 24)
    }
}


struct HomeView: View {
    @StateObject
    private var vm = HomeViewModel()
    var onGoToSearch: (() -> Void)? = nil
    var body: some View {
        let isGlobalEmpty = vm.totalCount == 0
        VStack(spacing: 0) {
            
            // Header
            HStack {
                Text("Home")
                    .font(.custom("LibreBaskerville-Regular", size: 34))
                    .padding(.leading, 18)
                
                Spacer()
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "person.fill")
                            .imageScale(.small))
                            .padding(.trailing, 18)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 15)
            
            // Tabs
            
            ShelfTabs(
                selected: $vm.selected,
                counts: isGlobalEmpty ? Array(repeating: 0, count: Shelf.allCases.count) : vm.counts
            )
            .padding(.horizontal, 20)
            .padding(.top, 8)
            
            // Content
            
            Group {
                if isGlobalEmpty {
                    EmptyStateView(
                        imageName: "NoBooks",
                        title: "No Saved Books Yet",
                        message: "Find a book using Search and add it to \nyour saved list.",
                        buttonTitle: "Go to Search",
                        buttonAction: {
                            onGoToSearch?()
                        })
                } else if vm.filtered.isEmpty {
                    VStack(spacing: 12) {
                        Image("NoBooks")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 260)
                            .padding(.top, 32)
                        
                        Text("No books in \(vm.selected.title) yet")
                            .foregroundStyle(.secondary)
                            .padding(.top, 24)
                        
                        Button("Go to Search") {
                            onGoToSearch?()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .foregroundStyle(.white)
                        .background(Color.orange)
                        .clipShape(Capsule())
                        .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 24)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.filtered, id: \.listId) {
                                book in NavigationLink {
                                    BookDetailView(vm: BookDetailViewModel(book: book))
                                } label: {
                                    BookRow(book: book)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.load()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
