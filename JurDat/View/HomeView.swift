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
        ScrollView(.vertical) {
            VStack{
                ForEach(vm.newCases) { newCase in
                    singleCaseView(caseItem: newCase)
                }
            }
        }
        .onAppear(perform: {
            vm.loadNewCases()
        })
    }
}

struct singleCaseView: View {
    
    let caseItem: Case
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
            
            VStack {
                HStack {
                    Text(caseItem.fileNumber)
                    
                    Text(caseItem.court.name)
                }
                
                Text(caseItem.type)
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
            }
        }
    }
}

#Preview {
    HomeView()
}
