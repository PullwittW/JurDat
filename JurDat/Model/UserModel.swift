//
//  UserModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 21.11.23.
//

import Foundation

struct DBUser: Codable {
    let userId: String
    let surname: String?
    let lastname: String?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    var favoriteCases: [String]?
    var favoriteNews: [String]?
    var lawsuits: [Lawsuit]?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.surname = ""
        self.lastname = ""
        self.photoUrl = auth.photoURL
        self.dateCreated = Date()
        self.isPremium = false
        self.favoriteCases = nil
        self.favoriteNews = nil
        self.lawsuits = nil
    }
    
    init(
        userId: String,
        email: String? = nil,
        surname: String? = nil,
        lastname: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        favoriteCases: [String]? = nil,
        favoriteNews: [String]? = nil,
        lawsuits: [Lawsuit]? = nil
    ) {
        self.userId = userId
        self.email = email
        self.surname = surname
        self.lastname = lastname
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.favoriteCases = favoriteCases
        self.favoriteNews = favoriteNews
        self.lawsuits = lawsuits
    }
    
//    func togglePremiumState() -> DBUser {
//        let currentValue = isPremium ?? false
//        return DBUser(userId: userId,
//                      email: email,
//                      photoUrl: photoUrl,
//                      dateCreated: dateCreated,
//                      isPremium: !currentValue)
//    }
    
//    mutating func togglePremiumStatus() {
//        let currentValue = isPremium ?? false
//        isPremium = !currentValue
//    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case surname = "surname"
        case lastname = "lastname"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "is_premium"
        case favoriteCases = "favorite_cases"
        case favoriteNews = "favorite_news"
        case lawsuits = "lawsuits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.surname = try container.decodeIfPresent(String.self, forKey: .surname)
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.favoriteCases = try container.decodeIfPresent([String].self, forKey: .favoriteCases)
        self.favoriteNews = try container.decodeIfPresent([String].self, forKey: .favoriteNews)
        self.lawsuits = try container.decodeIfPresent([Lawsuit].self, forKey: .lawsuits)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.surname, forKey: .surname)
        try container.encodeIfPresent(self.lastname, forKey: .lastname)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.favoriteCases, forKey: .favoriteCases)
        try container.encodeIfPresent(self.favoriteNews, forKey: .favoriteNews)
        try container.encodeIfPresent(self.lawsuits, forKey: .lawsuits)
    }
}
