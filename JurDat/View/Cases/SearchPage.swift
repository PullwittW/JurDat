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
            .onAppear {
                vm.loadNewCases()
            }
        }
    }
    
    var searchResults: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(vm.filterCases(searchText: searchText)) { newCase in
                    singleCaseView(caseItem: newCase)
                }
            }
        }
    }
}

struct singleCaseView: View {
    
    @StateObject var vm = CaseViewModel()
    let caseItem: Case
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(caseItem.fileNumber)
                .font(.title2)
                .fontWeight(.bold)
            
            
            Text("\(caseItem.court.name) vom \(vm.formattedDate(dateString: caseItem.date))")
                .fontWeight(.semibold)
            
            Text(caseItem.type)
            
            Divider()
                
        }
        .navigationTitle("Suche")
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    SearchPage()
}
