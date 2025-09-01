//
//  Shelf.swift
//  MyLibrary
//
//  Created by Софія Шаламай on 19.08.2025.
//

import Foundation

enum Shelf: String, CaseIterable, Codable {
    case reading, completed, wishlist, none
    
    var title: String {
        switch self {
        case .reading:   return "Reading"
        case .completed: return "Completed"
        case .wishlist:  return "Wishlist"
        case .none:      return "None"
        }
    }
}
