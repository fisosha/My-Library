// BookRepository.swift
// MyLibrary
//
// Created by Софія Шаламай on 20.08.2025.
//
// BookRepository.swift

// BookRepository.swift
import Foundation
import FirebaseAuth

protocol BookRepositoryProtocol {
    func search(query: String) async throws -> [Book]
    func getPopular() async throws -> [Book]
    func getSaved() async -> [Book]
    func setShelf(_ book: Book, shelf: Shelf) async
    func remove(_ book: Book) async
}

final class BookRepository: BookRepositoryProtocol {
    
    static let shared = BookRepository()
    
    private let api = OpenLibraryAPI()
    private var store: CacheManager
    private var currentUID: String = "guest"
    
    private var memorySearchCache = [String: [Book]]()
    private var savedBooks: [Book] = []
    private let popularKey = "__popular__"
    
    private init() {
        self.store = CacheManager(userId: "guest")
        Task { [weak self] in
            guard let self else { return }
            let loaded = await self.store.load()
            await MainActor.run { self.savedBooks = loaded }
        }
    }
    
    func switchUser(to uid: String?) async {
        let uidOrGuest = uid?.replacingOccurrences(of: "/", with: "_") ?? "guest"
        currentUID = uidOrGuest
        store = CacheManager(userId: uidOrGuest)
        savedBooks = await store.load()
    }
    
    
    func search(query: String) async throws -> [Book] {
        let key = query.lowercased()
        if let cached = memorySearchCache[key] { return cached }
        let result = try await api.search(query: query)
        memorySearchCache[key] = result
        return result
    }
    
    func getPopular() async throws -> [Book] {
        if let cached = memorySearchCache[popularKey] { return cached }
        let result = try await api.trending()
        memorySearchCache[popularKey] = result
        return result
    }
    
    func getSaved() async -> [Book] {
        savedBooks
    }
    
    func setShelf(_ book: Book, shelf: Shelf) async {
        var updated = book
        updated.shelf = shelf
        
        if let idx = savedBooks.firstIndex(where: { $0.listId == updated.listId }) {
            savedBooks[idx] = updated
        } else {
            savedBooks.append(updated)
        }
        await store.save(savedBooks)
    }
    
    func remove(_ book: Book) async {
        savedBooks.removeAll { $0.listId == book.listId }
        await store.save(savedBooks)
    }
}
