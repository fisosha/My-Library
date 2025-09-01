//
//  BottomBarView.swift
//  MyLibrary
//
//  Created by Софія Шаламай on 19.08.2025.
//

import SwiftUI

enum TabItem {
    case home, search, settings
}

struct BottomBar: View {
    let selected: TabItem
    let onSelect: (TabItem) -> Void
    
    var body: some View {
        HStack {
            barItem(.home,    "house.fill", "Home")
            barItem(.search,  "magnifyingglass", "Search")
            barItem(.settings,"gearshape", "Settings")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }
    
    @ViewBuilder
    private func barItem(_ item: TabItem, _ sf: String, _ title: String) -> some View {
        let isActive = selected == item
        Button {
            onSelect(item)
        } label: {
            HStack(spacing: 6) {
                Image(systemName: sf)
                if isActive { Text(title) }
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(isActive ? .white : .primary)
            .padding(.horizontal, isActive ? 16 : 12)
            .padding(.vertical, 10)
            .background(isActive ? Color.orange : Color(.systemGray6))
            .clipShape(Capsule())
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
