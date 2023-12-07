//
//  SearchPage.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import SwiftUI

struct SearchPage: View {
    
    @StateObject var vm = CaseViewModel()
    @State private var searchText = ""
    @State private var performSearch: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.newCases.isEmpty {
                    VStack(spacing: 10) {
                        ProgressView()
                        Text("Lade Fälle...")
                    }
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(vm.filterCases(searchText: searchText)) { caseItem in
                                SingleCaseView(caseItem: caseItem)
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Urteile")
            .task {
                if performSearch {
                    try? await vm.loadNewCases()
                    performSearch = false
                }
            }
            .searchable(text: $searchText, prompt: "Suche nach Urteilen")
            .refreshable {
                try? await vm.loadNewCases()
            }
        }
    }
}

#Preview {
    SearchPage()
}
