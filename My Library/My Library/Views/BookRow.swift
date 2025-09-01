//
// BookRow.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
//

import SwiftUI

struct BookRow: View {
    let book: Book
    var body: some View {
        ZStack {
            if let url = book.coverURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().scaledToFill()
                    case .failure(_):
                        Color(.systemGray6)
                    case .empty:
                        Color(.systemGray6)
                    @unknown default:
                        Color(.systemGray6)
                    }
                }
            } else {
                Color(.systemGray6)
            }
        }
        .frame(width: 56, height: 72)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
        VStack(alignment: .leading, spacing: 4) {
            Text(book.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(book.author)
                .foregroundStyle(.secondary)
                .font(.subheadline)
            
            HStack(spacing: 4) {
                ForEach(0..<5, id: \.self) { i in
                    Image(systemName: i < book.rating ? "star.fill" : "star")
                        .foregroundStyle(i < book.rating ?
                            .orange : .gray.opacity(0.5))
                }
            }
        }
        Spacer()
            .padding(12)
            .background(Color(.systemGray6)
                .opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct Stars: View {
    let rating: Int
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5, id: \.self) { i in
                Image(systemName: i < rating ? "star.fill" : "star")
                    .font(.caption)
                    .foregroundStyle(Color.orange)
            }
        }
    }
    
}
