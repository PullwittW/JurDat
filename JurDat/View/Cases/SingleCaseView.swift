//
//  SingleCaseView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import Foundation
import SwiftUI


struct SingleCaseView: View {
    
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
        .padding()
    }
}

