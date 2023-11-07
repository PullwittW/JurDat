//
//  LawViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import Foundation
import SwiftUI

class LawBookViewModel: ObservableObject {
    
    @Published var lawBooks: [LawBook] = []
    
    // URL: https://de.openlegaldata.io/api/law_books/?slug=&code=&latest=true
    
    func loadLawBooks() {
        Task {
            let url = URL(string: "https://de.openlegaldata.io/api/law_books/?slug=&code=&latest=true&page_size=50")!
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS")
                }
                let lawBooksResult = try JSONDecoder().decode(LawBookResult.self, from: data)
                lawBooks = lawBooksResult.results
                
            } catch {
                print(error.localizedDescription)
            }
        }
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
