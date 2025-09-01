//
// BookDetailViewModel.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
//

import SwiftUI

@MainActor
final class BookDetailViewModel: ObservableObject {
    @Published var book: Book
    private let repo: BookRepositoryProtocol = BookRepository.shared
    init(book: Book) {
        self.book = book
    }
    var shelf: Shelf {
        book.shelf
    }
    func setShelf(_ shelf: Shelf) {
        Task {
            await repo.setShelf(book, shelf: shelf)
            await MainActor.run {
                self.book.shelf = shelf
            }
        }
    }
}

extension BookDetailViewModel {
    static var mock: BookDetailViewModel {
        BookDetailViewModel(book: .sample)
    }
}
