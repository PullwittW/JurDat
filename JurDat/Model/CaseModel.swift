//
//  CaseModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Case]
}

// MARK: - Cases
struct Case: Codable, Identifiable {
    let id: Int
    let slug: String
    let court: Court
    let fileNumber, date: String
    let createdDate, updatedDate: String
    let type, ecli, content: String

    enum CodingKeys: String, CodingKey {
        case id, slug, court
        case fileNumber = "file_number"
        case date
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case type, ecli, content
    }
}
