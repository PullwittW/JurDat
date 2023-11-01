//
//  UserModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import Foundation

struct user: Codable {
    let userId = UUID().uuidString
    let userSurname: String
    let userLastname: String
    let jobTitle: String
}
