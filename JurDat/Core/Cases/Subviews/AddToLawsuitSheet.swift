//
//  AddToLawsuitSheet.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 23.11.23.
//

import Foundation
import SwiftUI

struct AddToLawsuitSheet: View {
    @StateObject private var userVM = UserViewModel()
    let caseItem: Case
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                if let user = userVM.user {
                    ScrollView {
                        ForEach(user.lawsuits ?? []) { lawsuit in
                            Text(lawsuit.lawsuitName)
                                .onTapGesture {
                                    userVM.addCaseToLawsuit(lawsuit: lawsuit, caseItem: caseItem)
                                }
                            
                            Divider()
                        }
                    }
                }
            }
//            .task {
//                try? await userVM.loadCurrentUser()
//            }
            .font(.headline)
            .padding()
        }
    }
}
