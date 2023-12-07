//
//  CasesManager.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 20.11.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class LawbookManager {
    
    static let shared = LawbookManager()
    private init() {}
    
    private let lawbookCollection = Firestore.firestore().collection("lawbooks")
    
    private func userDocument(lawbookId: Int) -> DocumentReference {
        lawbookCollection.document(String(lawbookId))
    }
    
    func uploadCase(lawbook: LawBook) async throws {
        try userDocument(lawbookId: lawbook.id).setData(from: lawbook, merge: false)
    }
    
    func getAllCases() async throws -> [LawBook] {
        let snapshot = try await lawbookCollection.getDocuments()
        
        var lawbooks: [LawBook] = []
        
        for document in snapshot.documents {
            let lawbook = try document.data(as: LawBook.self)
            lawbooks.append(lawbook)
        }
        return lawbooks
    }
}
