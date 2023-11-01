//
//  CourtModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import Foundation

// MARK: - Court
struct Court: Codable {
    let id: Int
    let name, slug: String
    let city: Int?
    let state: Int
    let jurisdiction, levelOfAppeal: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, city, state, jurisdiction
        case levelOfAppeal = "level_of_appeal"
    }
}
