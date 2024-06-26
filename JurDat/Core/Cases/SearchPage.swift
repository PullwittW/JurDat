//
//  SearchPage.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import SwiftUI

struct SearchPage: View {
    
    @EnvironmentObject var caseVM: CaseViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if caseVM.newCases.isEmpty {
                    VStack(spacing: 10) {
                        ProgressView()
                        Text("Lade Fälle...")
                    }
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(caseVM.filterCases(searchText: searchText)) { caseItem in
                                SingleCaseView(caseItem: caseItem)
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Urteile")
            .refreshable {
                try? await caseVM.loadNewCases()
            }
        }
    }
}

#Preview {
    SearchPage()
}
