import Foundation

actor CacheManager {
    private let url: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(userId: String) {
        let safe = userId.replacingOccurrences(of: "/", with: "_")
        let filename = "saved_books_\(safe).json"
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.url = dir.appendingPathComponent(filename)
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }

    func load() async -> [Book] {
        guard FileManager.default.fileExists(atPath: url.path) else { return [] }
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode([Book].self, from: data)
        } catch {
            print("Disk load error:", error)
            return []
        }
    }

    func save(_ books: [Book]) async {
        do {
            let data = try encoder.encode(books)
            try data.write(to: url, options: .atomic)
        } catch {
            print("Disk save error:", error)
        }
    }
}
