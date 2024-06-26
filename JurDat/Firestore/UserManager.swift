//
//  UserManager.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 14.11.23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func setUserSurname(userId: String, surname: String) async throws {
        print("Saving Surname")
        let data: [String:Any] = [
            DBUser.CodingKeys.surname.rawValue : surname
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func setUserLastname(userId: String, lastname: String) async throws {
        print("Saving Lastname")
        let data: [String:Any] = [
            DBUser.CodingKeys.lastname.rawValue : lastname
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateUserProfileImagePath(userId: String, path: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.profileImagePath.rawValue : path
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
//    func creatNewUser(auth: AuthDataResultModel) async throws {
//        var userData: [String:Any] = [
//            "user_id" : auth.uid,
//            "date_created" : Timestamp(),
//        ]
//        if let email = auth.email {
//            userData["email"] = email
//        }
//        if let photoUrl = auth.photoURL {
//            userData["photo_url"] = photoUrl
//        }
//        
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await userDocument(userId: userId).getDocument()
//        
//        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//        
//        let email = data["email"] as? String
//        let photoUrl = data["photo_url"] as? String
//        let dateCreated = data["date_created"] as? Date
//        
//        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
//    }
    
//    func updateUserPremiumStatus(user: DBUser) async throws {
//        try userDocument(userId: user.userId).setData(from: user, merge: true)
//    }
    
//    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
//        let data: [String:Any] = [
//            DBUser.CodingKeys.isPremium.rawValue : isPremium
//        ]
//        try await userDocument(userId: userId).updateData(data)
//    }
    
    func addUserFavoriteCases(userId: String, favoriteCaseID: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.favoriteCases.rawValue : FieldValue.arrayUnion([favoriteCaseID])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserFavoriteCases(userId: String, favoriteCaseID: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.favoriteCases.rawValue : FieldValue.arrayRemove([favoriteCaseID])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func addLawsuit(userId: String, lawsuit: Lawsuit) async throws {
        guard let data = try? encoder.encode(lawsuit) else {
            throw URLError(.badURL)
        }
        let dict: [String:Any] = [
            DBUser.CodingKeys.lawsuits.rawValue : FieldValue.arrayUnion([data])
        ]
        try await userDocument(userId: userId).updateData(dict)
    }
    
    func removeLawsuit(userId: String, lawsuit: Lawsuit) async throws {
        guard let data = try? encoder.encode(lawsuit) else {
            throw URLError(.badURL)
        }
        let dict: [String:Any] = [
            DBUser.CodingKeys.lawsuits.rawValue : FieldValue.arrayRemove([data])
        ]
        try await userDocument(userId: userId).updateData(dict)
    }
    
    func addUserFavoriteNews(userId: String, news: News) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.favoriteNews.rawValue : FieldValue.arrayUnion([news.titel])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserFavoriteNews(userId: String, news: News) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.favoriteNews.rawValue : FieldValue.arrayRemove([news.titel])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func addCaseToLawsuit(userId: String, newLawsuit: Lawsuit, oldLawsuit: Lawsuit) async throws {
        try await removeLawsuit(userId: userId, lawsuit: oldLawsuit)
        guard let newData = try? encoder.encode(newLawsuit) else {
            throw URLError(.badURL)
        }
        let newDict: [String:Any] = [
            DBUser.CodingKeys.lawsuits.rawValue : FieldValue.arrayUnion([newData])
        ]
        try await userDocument(userId: userId).updateData(newDict)
    }
}
