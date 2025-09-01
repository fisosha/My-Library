//
//  ShelfTabs.swift
//  MyLibrary
//
//  Created by Софія Шаламай on 19.08.2025.
//


import SwiftUI

struct ShelfTabs: View {
    @Binding var selected: Shelf
    let counts: [Int]
    
    var body: some View {
        
        let shelves = Array(Shelf.allCases.enumerated())
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(shelves, id: \.1) { (idx, shelf) in
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack(spacing: 6) {
                            
                            Text(shelf.title)
                                .lineLimit(1)
                                .minimumScaleFactor(1.0)
                                .allowsTightening(true)
                                .foregroundColor(selected == shelf ? .primary : .secondary)
                            
                            if counts.indices.contains(idx) {
                                Text("\(counts[idx])")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                    .padding(.horizontal, 6).padding(.vertical, 2)
                                    .background(Color.orange.opacity(0.15))
                                    .clipShape(Capsule())
                            }
                        }
                        Rectangle()
                            .fill(selected == shelf ? Color.orange : .clear)
                            .frame(height: 3)
                            .clipShape(Capsule())
                    }
                    
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            selected = shelf
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
