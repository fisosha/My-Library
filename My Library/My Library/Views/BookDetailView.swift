//
// BookDetailView.swift
// MyLibrary
//
// Created by Софія Шаламай on 19.08.2025.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: BookDetailViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Cover + кнопки
                ZStack(alignment: .bottomLeading) {
                    cover
                    HStack(spacing: 18) {
                        actionChip(icon: "heart.fill", shelf: .wishlist)
                        actionChip(icon: "book.fill", shelf: .reading)
                        actionChip(icon: "checkmark.circle.fill", shelf: .completed)
                    }
                    .padding(.bottom, 18)
                    .padding(.leading, 18)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                // Заголовок + автор
                VStack(alignment: .leading, spacing: 6) {
                    Text(vm.book.title)
                        .font(.system(size: 22, weight: .semibold))
                    Text(vm.book.author)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) {
                            i in Image(systemName: i < vm.book.rating ? "star.fill" : "star")
                                .foregroundStyle(i < vm.book.rating ? .orange : .gray.opacity(0.5))
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 16)
                
                // Опис (поки статичний)
                Text("""
                     Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s... 
""")
                .foregroundStyle(.secondary)
                .lineSpacing(3)
                .padding(.horizontal, 16)
                
                Spacer(minLength: 24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Search")
                    }
                }
                .tint(.orange)
            }
        }
    }
    // MARK: - Subviews
    
    @ViewBuilder
    private var cover: some View {
        ZStack(alignment: .bottom) {
            if let url = vm.book.coverURL {
                AsyncImage(url: url) {
                    phase in
                    switch phase {
                    case .success(let img):
                        img.resizable()
                            .scaledToFill()
                    default:
                        Color(.systemGray6)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 420)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                ZStack {
                    Color(.systemGray6)
                    Image(systemName: "book.closed")
                        .imageScale(.large)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 420)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private func actionChip(icon: String, shelf: Shelf) -> some View {
        let active = vm.book.shelf == shelf
        Button {
            vm.setShelf(shelf)
        } label: {
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundStyle(active ? .white : .primary)
                .frame(width: 56, height: 48)
                .background(active ? Color.orange : Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12)) } .buttonStyle(.plain)
    }
}
