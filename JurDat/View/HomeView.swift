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
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke()
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
    HomeView()
}
