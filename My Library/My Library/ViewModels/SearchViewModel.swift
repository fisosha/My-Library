//
// SearchViewModel.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
//

import Foundation
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [Book] = []
    @Published var popular: [Book] = []
    @Published var isLoading = false
    
    private let repo: BookRepositoryProtocol = BookRepository.shared
    func loadPopularIfNeeded() async {
        guard popular.isEmpty else {
            return
        }
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            popular = try await repo.getPopular()
        }
        catch {
            print("popular error:", error)
        }
    }
    func performSearch() async {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else {
            results = [];
            return
        }
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            results = try await repo.search(query: q)
        }
        catch {
            print("search error:", error)
        }
    }
}
