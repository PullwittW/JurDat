//
//  lawsuitModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 07.11.23.
//

import Foundation

struct lawsuit: Codable, Identifiable {
    let id: String = UUID().uuidString
    let lawsuitName: String
    let mandateName: String?
    let fileNumbers: [Int]
}
