//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = CaseViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    ForEach(vm.newCases) { newCase in
                        singleCaseView(caseItem: newCase)
                    }
                }
            }
        }
        .onAppear {
            vm.loadNewCases()
        }
    }
}

struct singleCaseView: View {
    
    let caseItem: Case
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(caseItem.fileNumber)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(caseItem.court.name)
            
            Text(caseItem.type)
        }
        .frame(width: .infinity, height: 100)
        .padding()
        .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 5)
    }
}

#Preview {
    HomeView()
}
