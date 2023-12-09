//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @StateObject private var caseVM = CaseViewModel()
//    @StateObject private var userVM = UserViewModel()
    @EnvironmentObject var userVM: UserViewModel
    @StateObject private var newsVM = NewsViewModel()
    @State var userName = "Wangu"
//    @State private var settingsSheet: Bool = false
    @State private var suitSheet: Bool = false
    @State private var newSuitSheet: Bool = false
    @State var newSuitName: String = ""
    @State var newSuitDescription: String = ""
    @State private var lawsuitCardSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if userVM.user != nil {
                    HomeHeader(userName: userName)
                
                    SuitHeader()
                        .padding(.vertical)
                    
                    ScrollView(showsIndicators: false) {
                        allSuitsCardView
                        PlusButton(suitSheet: $suitSheet)
                            .padding(.top, 30)
                    }
                    
                    Spacer()
                } else {
                    HomeHeader(userName: userName)
                                
                    SuitHeader()
                        .padding(.vertical)
                    
                    ScrollView(showsIndicators: false) {
                        noUserCard
                    }
                    
                    Spacer()
                }
            }
            .task {
//                try? await userVM.loadCurrentUser()
//                try? await caseVM.loadNewCases()
//                try? await newsVM.loadNews()
            }
            .padding()
            .sheet(isPresented: $suitSheet) {
                SuitSheetView(newSuitSheet: $newSuitSheet)
                    .presentationDetents([.height(UIScreen.main.bounds.height*0.15)])
                    .sheet(isPresented: $newSuitSheet) {
                        newSuitSheetView
                            .presentationDetents([.medium])
                    }
            }
        }
    }
    
    var allSuitsCardView: some View {
        VStack {
            if let user = userVM.user {
                ForEach(user.lawsuits ?? []) { suit in
                    if suit.lawsuitName != "Favoriten" {
                        LawsuitCard(suit: suit, color: "thirdColor")
                            .padding(.bottom, 5)
                    }
                }
            }
        }
    }
    
    var newSuitSheetView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    userVM.addLawsuit(lawsuit: Lawsuit(
                        lawsuitName: newSuitName,
                        lawsuitDescription: newSuitDescription,
                        fileNumbers: []))
                    newSuitName = ""
                    newSuitDescription = ""
                    suitSheet = false
                    newSuitSheet = false
                }, label: {
                    Text("Erstellen")
                })
            }
            TextField("Neuen Fall anlegen", text: $newSuitName)
                .font(.headline)
            
            Divider()
//            PurpleLine()
            TextField("Mandaten, Beschreibung, etc. hinzufügen", text: $newSuitDescription, axis: .vertical)
            
            Spacer()
        }
        .padding()
    }
    
    var noUserCard: some View {
        NavigationLink {
            SettingsView()
        } label: {
            HStack {
                Spacer()
                Text("Logge dich ein um neue Fälle anzulegen!")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .foregroundColor(.white)
            .frame(height: 125)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.theme.purple)
            }
        }
    }
}
