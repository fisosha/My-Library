//
//  SearchView.swift
//  MyLibrary
//
//  Created by Софія Шаламай on 19.08.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            HStack {
                Text("Search")
                    .font(.custom("LibreBaskerville-Regular", size: 34))
                    .padding(.leading, 18)
                Spacer()
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "person.fill").imageScale(.small))
                    .padding(.trailing, 18)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 15)
            
            HStack(spacing: 10) {
                TextField("Search", text: $vm.query)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await vm.performSearch()
                        }
                    }
                
                Button {
                    Task {
                        await vm.performSearch()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                        .padding(8)
                        .foregroundStyle(Color.orange)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 14)
            .frame(height: 44)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // Content
            if vm.isLoading {
                ProgressView().padding(.top, 24)
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // Results
                        if !vm.results.isEmpty {
                            Text("Results")
                                .font(.headline)
                                .padding(.horizontal, 20)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(vm.results, id: \.listId) { book in
                                    NavigationLink {
                                        BookDetailView(vm: BookDetailViewModel(book: book))
                                    } label: {
                                        BookRow(book: book)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        // Popular
                        if vm.results.isEmpty && vm.query.trimmingCharacters(in: .whitespaces).isEmpty {
                            Text("Bestselling / Popular")
                                .font(.headline)
                                .padding(.horizontal, 20)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(vm.popular, id: \.listId) { book in
                                    NavigationLink {
                                        BookDetailView(vm: BookDetailViewModel(book: book))
                                    } label: {
                                        BookRow(book: book)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 16)
                }
            }
        }
        .task { await vm.loadPopularIfNeeded() }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
