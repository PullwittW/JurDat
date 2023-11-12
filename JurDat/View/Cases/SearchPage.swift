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
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.newCases.isEmpty {
                    ProgressView()
                } else {
                    VStack {
                        searchResults
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Suche nach Urteilen")
            .navigationTitle("Urteile")
            .navigationBarBackButtonHidden(true)
            .onAppear {
                vm.loadNewCases()
            }
        }
    }
    
    var searchResults: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(vm.filterCases(searchText: searchText)) { newCase in
                    SingleCaseView(caseItem: newCase)
                        .onTapGesture {
                            print(newCase.fileNumber)
                        }
                }
            }
        }
    }
}

#Preview {
    SearchPage()
}
