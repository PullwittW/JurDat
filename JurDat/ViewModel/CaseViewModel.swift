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
    
    @Published var newCases: [Case] = []
    
    static let APIKey = "d90efaba4ab6b4d0ccbaf0cc2c58fb6e97769dbe"
    
    
    // URL-Cases: https://de.openlegaldata.io/api/cases/
    
    func loadNewCases() {
        Task {
            let url = URL(string: "https://de.openlegaldata.io/api/cases/?ordering=-date")!
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
    
    
}
