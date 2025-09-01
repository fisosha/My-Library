//
//  OpenLibraryAPI.swift
//  MyLibrary
//
//  Created by Софія Шаламай on 20.08.2025.
//

import Foundation

struct OpenLibraryAPI {
    
    private let base = URL(string: "https://openlibrary.org")!
    
    struct SearchHit: Decodable {
        let title: String?
        let author_name: [String]?
        let cover_i: Int?
        let isbn: [String]?
    }
    struct SearchResponse: Decodable { let docs: [SearchHit] }
    
    struct TrendingWork: Decodable {
        let title: String?
        let authors: [TrendingAuthor]?
        let cover_i: Int?
        let first_publish_year: Int?
        let isbn: [String]?    // іноді теж присутнє
    }
    struct TrendingAuthor: Decodable { let name: String? }
    struct TrendingResponse: Decodable { let works: [TrendingWork] }
    
    private func coverURL(coverId: Int?, isbn: String?) -> URL? {
        if let id = coverId {
            return URL(string: "https://covers.openlibrary.org/b/id/\(id)-L.jpg")
        }
        if let isbn = isbn {
            return URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-L.jpg")
        }
        return nil
    }
    
    func search(query: String) async throws -> [Book] {
        var comps = URLComponents(url: base.appendingPathComponent("/search.json"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [URLQueryItem(name: "q", value: query), URLQueryItem(name: "limit", value: "30")]
        let (data, _) = try await URLSession.shared.data(from: comps.url!)
        
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        return decoded.docs.map { hit in
            let title  = hit.title ?? "Untitled"
            let author = hit.author_name?.first ?? "Unknown"
            let url    = coverURL(coverId: hit.cover_i, isbn: hit.isbn?.first)
            return Book(title: title, author: author, rating: 0, coverURL: url, shelf: .none)
        }
    }
    
    func trending() async throws -> [Book] {
        let url = base.appendingPathComponent("/trending/thisweek.json")
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(TrendingResponse.self, from: data)
        return decoded.works.map { w in
            let title  = w.title ?? "Untitled"
            let author = w.authors?.first?.name ?? "Unknown"
            let url    = coverURL(coverId: w.cover_i, isbn: w.isbn?.first)
            return Book(title: title, author: author, rating: 0, coverURL: url, shelf: .none)
        }
    }
}
