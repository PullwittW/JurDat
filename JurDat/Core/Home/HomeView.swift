//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var userVM: SettingsViewModel
    @State var userName = "Wangu"
    @State private var suitSheet: Bool = false
    @State private var newSuitSheet: Bool = false
    @State var newSuitName: String = ""
    @State var newSuitDescription: String = ""
    @State private var lawsuitCardSheet: Bool = false
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if userVM.user != nil {
                    HomeHeader()
                
                    SuitHeader()
                        .padding(.vertical)
                    
                    ScrollView(showsIndicators: false) {
                        allSuitsCardView
                        PlusButton(suitSheet: $suitSheet)
                            .padding(.top, 30)
                    }
                    
                    Spacer()
                } else {
                    HomeHeader()
                                
                    SuitHeader()
                        .padding(.vertical)
                    
                    ScrollView(showsIndicators: false) {
                        noUserCard
                    }
                    
                    Spacer()
                }
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
        LazyVStack {
//            if let user = userVM.user {
//                ForEach(userVM.userLawsuits) { suit in
//                    LawsuitCard(suit: suit, color: "thirdColor")
//                        .padding(.bottom, 5)
//                }
//            }
            ForEach(userVM.userLawsuits.sorted(by: { $0.lawsuitName < $1.lawsuitName })) { suit in
                LawsuitCard(lawsuit: suit)
                    .padding(.bottom, 5)
            }
        }
    }
    
    var newSuitSheetView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    if newSuitName.count < 3 {
                        let customError: Error = customError.noLawsuitName
                        error = customError
                        showError.toggle()
                    } else {
                        userVM.addLawsuit(lawsuit: Lawsuit(
                            lawsuitName: newSuitName,
                            lawsuitDescription: newSuitDescription,
                            fileNumbers: []))
                        newSuitName = ""
                        newSuitDescription = ""
                        suitSheet = false
                        newSuitSheet = false
                    }
                }, label: {
                    Text("Erstellen")
                        .bold()
                })
            }
            TextField("Titel hinzufügen", text: $newSuitName)
                .font(.headline)
            
            Divider()
            TextField("Mandaten, Beschreibung, etc. hinzufügen", text: $newSuitDescription, axis: .vertical)
            
            Spacer()
        }
        .padding()
        .alert(error?.localizedDescription ?? "Ein Fehler ist aufgetreten", isPresented: $showError) {
            Button("OK") {
                
            }
        }
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
