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
        VStack {
            
            Text(searchText)
            
            searchResults
        }
        .searchable(text: $searchText)
        .onAppear {
            vm.loadNewCases()
        }
    }
    
    var searchResults: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(vm.newCases) { newCase in
                    singleCaseView(caseItem: newCase)
                }
            }
        }
    }
}

struct singleCaseView: View {
    
    let caseItem: Case
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.gray)
                .padding(5)
            
            VStack(alignment: .leading) {
                Text(caseItem.fileNumber)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(caseItem.court.name)
                    .fontWeight(.semibold)
                
                Text(caseItem.type)
            }
            .padding()
        }
    }
}

#Preview {
    SearchPage()
}
