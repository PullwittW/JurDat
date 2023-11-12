//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @StateObject private var vm = CaseViewModel()
    @State var userName = "Wangu"
    @State private var settingsSheet: Bool = false
    @State private var suitSheet: Bool = false
    @State private var newSuitSheet: Bool = false
    @State var newSuitName: String = ""
    @State var newSuitDescription: String = ""
    
    var body: some View {
        VStack {
            HomeHeader(userName: userName, settingsSheet: $settingsSheet)
            
            favoritesCardView
        
            SuitHeader()
                .padding(.vertical)
            
            ScrollView {
                allSuitsCardView
                PlusButton(suitSheet: $suitSheet)
                    .padding(.top, 30)
            }
            
            Spacer()
            
        }
        .padding()
        .fullScreenCover(isPresented: $settingsSheet) {
            RootView()
        }
        .sheet(isPresented: $suitSheet) {
            SuitSheetView(newSuitSheet: $newSuitSheet)
                .presentationDetents([.height(UIScreen.main.bounds.height*0.15)])
                .sheet(isPresented: $newSuitSheet) {
                    newSuitSheetView
                        .presentationDetents([.medium])
                }
        }
    }
    
    var favoritesCardView: some View {
        ForEach(vm.lawsuits) { suit in
            if suit.lawsuitName == "Favoriten" {
                LawsuitCard(suit: suit)
            }
        }
    }
    
    var allSuitsCardView: some View {
        ForEach(vm.lawsuits) { suit in
            if suit.lawsuitName != "Favoriten" {
                LawsuitCard(suit: suit)
            }
        }
    }
    
    var newSuitSheetView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    vm.lawsuits.append(Lawsuit(lawsuitName: newSuitName, lawsuitDescription: newSuitDescription, fileNumbers: []))
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
            TextField("Mandaten, Beschreibung, etc. hinzufügen", text: $newSuitDescription, axis: .vertical)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
