//
//  LawViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import Foundation
import SwiftUI

@MainActor
class LawBookViewModel: ObservableObject {

    @Published var lawBooks: [LawBook] = []
    @Published var singleLawbook: [specificLawbook] = []
    
    // URL: https://de.openlegaldata.io/api/law_books/?slug=&code=&latest=true&limit=1200
    // Specific Book: https://de.openlegaldata.io/api/laws/?book_id=2215&book__latest=true
    
    func loadSpecificLawbook(bookId: String) async throws {
        print("LOADING SPECIFIC LAWBOOK")
        guard let url = URL(string: "https://de.openlegaldata.io/api/laws/?book_id=\(bookId)&book__latest=true") else { return }
        singleLawbook = []
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS")
                }
                let lawBookResult = try JSONDecoder().decode(specificLawbookResult.self, from: data)
                singleLawbook.self = lawBookResult.results
                print("SUCCESS LOADING LAWBOOK")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    func loadLawBook() async throws {
//        guard let url = URL(string: "https://de.openlegaldata.io/api/law_books/?slug=patg&code=&latest=true") else { return }
//        Task {
//            do {
//                let (data, response) = try await URLSession.shared.data(from: url)
//                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
//                    print("SUCCESS LOADING LAWBOOK")
//                }
//                let lawBooksResult = try JSONDecoder().decode(LawBookResult.self, from: data)
//                lawBooks = lawBooksResult.results
//                
//                For uploading cases to Firestore
//                for lawbook in lawBooks {
//                    try? await LawbookManager.shared.uploadCase(lawbook: lawbook)
//                }
//                
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }

    // For Storing in Firestore
    func getAllLawbooks() async throws {
        self.lawBooks = try await LawbookManager.shared.getAllCases()
    }
    
    func filterLawBooks(searchText: String) -> [LawBook] {
        if searchText.isEmpty {
            return lawBooks
        } else {
            return lawBooks.filter {
                $0.title!.contains(searchText)
            }
        }
    }
    
}
