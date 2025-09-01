//
// HTTPClient.swift
// MyLibrary
//
// Created by Софія Шаламай on 20.08.2025.
//

import Foundation

struct HTTPClient {
    static let shared = HTTPClient()
    private let session: URLSession
    private init() {
        let conf = URLSessionConfiguration.default
        conf.requestCachePolicy = .returnCacheDataElseLoad
        conf.urlCache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 200 * 1024 * 1024
        )
        session = URLSession(configuration: conf)
    }
    func get<T: Decodable>(_ url: URL) async throws -> T {
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
