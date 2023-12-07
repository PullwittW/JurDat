//
//  CaseViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 02.11.23.
//

import Foundation
import SwiftUI
import Firebase

@MainActor
class CaseViewModel: ObservableObject {
    @Published var newCases: [Case] = []
    
    static let APIKey = "d90efaba4ab6b4d0ccbaf0cc2c58fb6e97769dbe"
    
    
    // URL-Cases: https://de.openlegaldata.io/api/cases/
    // Complete URL: https://de.openlegaldata.io/api/cases/?court=1&court__jurisdiction=&court__level_of_appeal=&court__slug=&court__state=&date_after=&date_before=&ecli=&file_number=&has_reference_to_law=&page=2&slug=
    // URL search cases: https://de.openlegaldata.io/case/(ag-essen-2022-10-14-131-c-13420)
    
    func loadNewCases() async throws {
        guard let url = URL(string: "https://de.openlegaldata.io/api/cases/?ordering=-date&page_size=50") else { return }
        Task {
            print("LOADING CASES")
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS LOADING CASES")
                }
                let newCasesResult = try JSONDecoder().decode(Result.self, from: data)
                newCases.self = newCasesResult.results
                print("Cases Count: \(self.newCases.count)")
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func formattedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Das Eingabeformat
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy" // Das Ausgabeformat
            return dateFormatter.string(from: date)
        } else {
            return "Ungültiges Datum"
        }
    }
    
    func filterCases(searchText: String) -> [Case] {
        if searchText.isEmpty {
                    return newCases
                } else {
                    return newCases.filter {
                        $0.fileNumber.contains(searchText)
                    }
                }
    }
//    
//    @Published var lawsuits: [Lawsuit] = [
//        Lawsuit(lawsuitName: "Favoriten", lawsuitDescription: "", fileNumbers: [])
//    ]
}
