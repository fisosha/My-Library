//
//  Book.swift
//  MyLibrary
//
//  Created by Софія Шаламай on 19.08.2025.
//

import Foundation

struct Book: Codable, Hashable {
    var title: String
    var author: String
    var rating: Int
    var coverURL: URL?
    var shelf: Shelf
    
    var listId: String {
        "\(title.lowercased())|\(author.lowercased())|\(coverURL?.absoluteString ?? "")"
    }
}

extension Book {
    static let sample = Book(
        title: "Sample Book",
        author: "Unknown Author",
        rating: 3,
        coverURL: nil,
        shelf: .reading
    )
}
