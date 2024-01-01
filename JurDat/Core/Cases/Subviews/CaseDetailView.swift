//
//  CaseDetailView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.11.23.
//

import SwiftUI

struct CaseDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: SettingsViewModel
    @State private var showAddToSuitSheet: Bool = false
    @State private var caseIsFavorite: Bool = false
    
    var caseItem: Case
    
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
            }
            .onAppear {
                Task {
                    try? await userVM.loadCurrentUser()
                }
                if caseIsSelected(slug: caseItem.slug) {
                    caseIsFavorite = true
                } else {
                    caseIsFavorite = false
                }
            }
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
                        if !caseIsFavorite {
                            userVM.addUserFavoriteCase(caseID: caseItem.slug)
                            caseIsFavorite = true
                            print("Case is favorite")
                        } else {
                            userVM.removeUserFavoiteCase(caseID: caseItem.slug)
                            caseIsFavorite = false
                            print("Case is no favorite")
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
            .sheet(isPresented: $showAddToSuitSheet) {
                List {
                    Section {
                        ForEach(userVM.user?.lawsuits ?? []) { suit in
//                        ForEach(userVM.userLawsuits) { suit in
                            Button {
                                userVM.addCaseToLawsuit(lawsuit: suit, caseItem: caseItem)
                                print("\(suit.lawsuitName) tapped")
                            } label: {
                                Text(suit.lawsuitName)
                            }
                        }
                    } header: {
                        Text("Zu Sammlung hinzufügen...")
                    }
                }
                .presentationDetents([.medium])
            }
        }
        .interactiveDismissDisabled()
    }
    
    var userView: some View {
        VStack {
            Text(caseItem.court.name)
                .font(.title2)
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
                Text(caseItem.content)
                    .lineSpacing(2.0)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
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
