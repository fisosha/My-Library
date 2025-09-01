//
// HomeViewModel.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
// import Foundation

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set)
    var books: [Book] = []
    @Published var selected: Shelf = .reading
    @Published var isLoading = false
    private let repo: BookRepositoryProtocol = BookRepository.shared
    var filtered: [Book] {
        books.filter {
            $0.shelf == selected
        }
    }
    var counts: [Int] {
        Shelf.allCases.map {
            shelf in books.filter {
                $0.shelf == shelf
            }
            .count
        }
    }
    var totalCount: Int {
        books.count
    }
    func load() {
        Task {
            isLoading = true
            let saved = await
            repo.getSaved()
            books = saved
            isLoading = false
        }
    }
    func setShelf(_ book: Book, to shelf: Shelf) {
        Task {
            await repo.setShelf(book, shelf: shelf)
            await refreshFromDisk()
        }
    }
    private func refreshFromDisk() async {
        let saved = await
        repo.getSaved()
        await MainActor.run {
            self.books = saved
        }
    }
}
