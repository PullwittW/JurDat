//
//  TabBarItem.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.01.24.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, cases, books, news
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .cases: return "magnifyingglass"
        case .books: return "text.book.closed"
        case .news: return "newspaper"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .cases: return "Suchen"
        case .books: return "Gesetze"
        case .news: return "News"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.theme.primaryPurple
        case .cases: return Color.theme.primaryPurple
        case .books: return Color.theme.primaryPurple
        case .news: return Color.theme.primaryPurple
        }
    }
}
