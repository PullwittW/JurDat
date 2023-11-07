//
//  CaseViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 02.11.23.
//

import Foundation
import SwiftUI

@MainActor
class CaseViewModel: ObservableObject {
    
    @Published var lawsuits: [lawsuit] = [
        lawsuit(lawsuitName: "Favoriten", mandateName: nil, fileNumbers: [])
    ]
    
    @Published var newCases: [Case] = [
        Case(id: 1,
             slug: "lg-koln-2029-11-13-84-o-24918",
             court: Court(id: 812,
                          name: "Landgericht Köln",
                          slug: "lg-koln",
                          city: 446,
                          state: 12,
                          jurisdiction: "Ordentliche Gerichtsbarkeit",
                          levelOfAppeal: "Landgericht"),
             fileNumber: "84 O 249/18",
             date: "2029-11-13",
             createdDate: "2020-02-06T11:01:05Z",
             updatedDate: "2020-12-10T13:50:38Z",
             type: "Urteil",
             ecli: "ECLI:DE:LGK:2029:1113.84O249.18.00",
             content: ""),
        Case(id: 2,
             slug: "lg-koln-2029-11-13-84-o-24918",
             court: Court(id: 812,
                          name: "Landgericht Köln",
                          slug: "lg-koln",
                          city: 446,
                          state: 12,
                          jurisdiction: "Ordentliche Gerichtsbarkeit",
                          levelOfAppeal: "Landgericht"),
             fileNumber: "S 46 AS 2230/15",
             date: "2029-11-13",
             createdDate: "2020-02-06T11:01:05Z",
             updatedDate: "2020-12-10T13:50:38Z",
             type: "Urteil",
             ecli: "ECLI:DE:LGK:2029:1113.84O249.18.00",
             content: ""),
        Case(id: 3,
             slug: "lg-koln-2029-11-13-84-o-24918",
             court: Court(id: 812,
                          name: "Landgericht Köln",
                          slug: "lg-koln",
                          city: 446,
                          state: 12,
                          jurisdiction: "Ordentliche Gerichtsbarkeit",
                          levelOfAppeal: "Landgericht"),
             fileNumber: "12 Sa 347/21",
             date: "2029-11-13",
             createdDate: "2020-02-06T11:01:05Z",
             updatedDate: "2020-12-10T13:50:38Z",
             type: "Urteil",
             ecli: "ECLI:DE:LGK:2029:1113.84O249.18.00",
             content: ""),
        Case(id: 4,
             slug: "lg-koln-2029-11-13-84-o-24918",
             court: Court(id: 812,
                          name: "Landgericht Köln",
                          slug: "lg-koln",
                          city: 446,
                          state: 12,
                          jurisdiction: "Ordentliche Gerichtsbarkeit",
                          levelOfAppeal: "Landgericht"),
             fileNumber: "131 C 134/20",
             date: "2029-11-13",
             createdDate: "2020-02-06T11:01:05Z",
             updatedDate: "2020-12-10T13:50:38Z",
             type: "Urteil",
             ecli: "ECLI:DE:LGK:2029:1113.84O249.18.00",
             content: "")
    ]
    
    static let APIKey = "d90efaba4ab6b4d0ccbaf0cc2c58fb6e97769dbe"
    
    
    // URL-Cases: https://de.openlegaldata.io/api/cases/
    // Complete URL: https://de.openlegaldata.io/api/cases/?court=1&court__jurisdiction=&court__level_of_appeal=&court__slug=&court__state=&date_after=&date_before=&ecli=&file_number=&has_reference_to_law=&page=2&slug=
    
    func loadNewCases() {
        Task {
            let url = URL(string: "https://de.openlegaldata.io/api/cases/?ordering=-date&page_size=100")!
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS")
                }
                let newCasesResult = try JSONDecoder().decode(Result.self, from: data)
                newCases = newCasesResult.results
                print(newCases)
                
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
                    return newCases.filter { $0.fileNumber.contains(searchText) }
                }
    }
    
}
