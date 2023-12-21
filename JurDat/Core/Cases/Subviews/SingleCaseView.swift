//
//  SingleCaseView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import Foundation
import SwiftUI

struct SingleCaseView: View {
    
    @EnvironmentObject var vm: CaseViewModel
    @State private var showCaseDetailView: Bool = false
    let caseItem: Case
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(caseItem.fileNumber)
                    .font(.title2)
                    .fontWeight(.bold)
                
                
                Text("\(caseItem.court.name) vom \(vm.formattedDate(dateString: caseItem.date))")
                    .fontWeight(.semibold)
                
                Text(caseItem.type)
                    .foregroundStyle(Color("TextColor"))
                    .font(.callout)
            }
            .padding()
            .onTapGesture {
                showCaseDetailView.toggle()
            }
            .sheet(isPresented: $showCaseDetailView, content: {
                CaseDetailView(caseItem: caseItem)
            })
        }
    }
}

#Preview {
    SingleCaseView(caseItem: Case(id: 1,
                                  slug: "lg-koln-2029-11-13-84-o-24918",
                                  court: Court(id: 812,
                                               name: "Landgericht Köln",
                                               slug: "lg-koln",
                                               city: 446,
                                               state: 12,
                                               jurisdiction: "Ordentliche Gerichtsbarkeit",
                                               levelOfAppeal: "Landgericht"),
                                  fileNumber: "84 O 249/18",
                                  date: "2029-11-13",
                                  createdDate: "2020-02-06T11:01:05Z",
                                  updatedDate: "2020-12-10T13:50:38Z",
                                  type: "Urteil",
                                  ecli: "ECLI:DE:LGK:2029:1113.84O249.18.00",
                                  content: ""))
}

