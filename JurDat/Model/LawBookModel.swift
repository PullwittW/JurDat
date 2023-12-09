//
//  LawBookModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import Foundation

// MARK: - LawBookResult
struct LawbookResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [LawBook]
}

// MARK: - LawBook
struct LawBook: Codable, Identifiable {
    let id: Int
    let code, slug: String
    let title, revisionDate: String?
    let latest: Bool?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id, code, slug, title
        case revisionDate = "revision_date"
        case latest, order
    }
}

// MARK: - LawbookResult
struct specificLawbookResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [specificLawbook]
}

// MARK: - Result
struct specificLawbook: Codable, Identifiable {
    let id: Int
    let book: Int
    let title, content: String?
    let slug: String
    let createdDate, updatedDate: String?
    let section: String?
    let amtabk, kurzue, doknr: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id, book, title, content, slug
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case section, amtabk, kurzue, doknr, order
    }
}
