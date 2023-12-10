//
//  CaseDetailView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.11.23.
//

import SwiftUI

struct CaseDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: UserViewModel
    @State private var showAddToSuitSheet: Bool = false
    @State private var caseIsFavorite: Bool = false
    
    let caseItem: Case
    
    private func caseIsSelected(slug: String) -> Bool {
        userVM.user?.favoriteCases?.contains(slug) == true
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if userVM.user != nil {
                        userView
                    } else {
                        noUserView
                    }
                }
                .padding()
                .task {
                    try? await userVM.loadCurrentUser()
                    if caseIsSelected(slug: caseItem.slug) {
                        print("Case is favorite")
                        print(userVM.user?.favoriteCases?.count)
                        caseIsFavorite = true
                    }
                }
//                .sheet(isPresented: $showAddToSuitSheet, content: {
//                    AddToLawsuitSheet(caseItem: caseItem)
//                        .presentationDetents([.height(UIScreen.main.bounds.height*0.4)])
//                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {dismiss()}, label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .fontWeight(.bold)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            if caseIsSelected(slug: caseItem.slug) {
                                userVM.removeUserFavoiteCase(caseID: caseItem.slug)
                                caseIsFavorite = false
                            } else {
                                userVM.addUserFavoriteCase(caseID: caseItem.slug)
                                caseIsFavorite = true
                            }
                        } label: {
                            Image(systemName: caseIsFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .fontWeight(.bold)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {showAddToSuitSheet.toggle()}, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .fontWeight(.bold)
                        })
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    var userView: some View {
        VStack {
            Text(caseItem.court.name)
                .font(.title3)
                .bold()
            
            HStack(spacing: 10) {
                Rectangle()
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 3)
                VStack(alignment: .leading) {
                    Text(caseItem.fileNumber)
                    Spacer()
                    Text(caseItem.type)
                        
                }
                .foregroundStyle(Color("TextColor"))
                .font(.callout)
                .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical)
            
            Divider()
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(caseItem.content.html2String)
            }
        }
    }
    
    var noUserView: some View {
        VStack {
            Text("Um Inhalte zu sehen, logge dich ein.")
        }
    }
}

#Preview {
    CaseDetailView(caseItem: Case(id: 1,
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
