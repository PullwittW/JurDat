//
//  LawBookModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import Foundation

// MARK: - LawBookResult
struct LawBookResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [LawBook]
}

// MARK: - LawBook
struct LawBook: Codable, Identifiable {
    let id: String = UUID().uuidString
    let code, slug, title, revisionDate: String
    let latest: Bool
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id, code, slug, title
        case revisionDate = "revision_date"
        case latest, order
    }
}
