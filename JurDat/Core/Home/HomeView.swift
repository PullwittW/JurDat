//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: SettingsViewModel
//    @EnvironmentObject var emailVM: SignInEmailViewModel
    @State private var suitSheet: Bool = false
    @State private var newSuitSheet: Bool = false
    @State var newSuitName: String = ""
    @State var newSuitDescription: String = ""
    @State private var lawsuitCardSheet: Bool = false
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    @State private var successFeedback: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if userVM.user != nil {
                    HomeHeader()
                
                    SuitHeader()
                        .padding(.vertical, 10)
                    
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
            .onAppear {
                userVM.showingSettingsView = true
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
                        successFeedback.toggle()
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
        .sensoryFeedback(.success, trigger: successFeedback)
    }
    
    var noUserCard: some View {
        NavigationLink {
            SettingsView()
        } label: {
            HStack {
                Spacer()
                Text("Registriere dich, um neue Fälle anzulegen!")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .foregroundColor(.white)
            .frame(height: 125)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.theme.primaryPurple)
            }
        }
    }
    
//    var nameSubmit: some View {
//        VStack {
//            
//            Text("Bitte bestätige noch einmal deinen Vor- und Nachnamen")
//                .multilineTextAlignment(.center)
//                .bold()
//                .foregroundStyle(Color.theme.textColor)
//            
//            TextField("Vorname", text: $userVM.userSurname)
//                .foregroundStyle(Color.white)
//                .textFieldStyle(.plain)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.theme.purple))
//            
//            TextField("Nachname", text: $userVM.userLastname)
//                .foregroundStyle(Color.white)
//                .textFieldStyle(.plain)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.theme.purple))
//            
//            Spacer()
//            
//            Button {
//                if userVM.userSurname.count < 3 || userVM.userLastname.count < 3{
//                    let customError: Error = customError.noCredentials
//                    error = customError
//                    showError.toggle()
//                } else {
//                    Task {
//                        try await userVM.setUserSurname()
//                        try await userVM.setUserLastname()
//                    }
//                    userVM.userSurname = ""
//                    userVM.userLastname = ""
//                    showNameSheet = false
//                    dismiss()
//                }
//            } label: {
//                PurpleButton(buttonName: "Bestätigen")
//            }
//        }
//        .padding()
//    }
}
