//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = CaseViewModel()
    @State var userName = "Wangu"
    @State private var suitSheet: Bool = false
    @State private var newSuitSheet: Bool = false
    @State var newSuitName: String = ""
    @State var newSuitDescription: String = ""
    
    var body: some View {
        VStack {
            homeHeader
            
            ScrollView {
                ForEach(vm.lawsuits) { suit in
                    if suit.lawsuitName == "Favoriten" {
                        lawsuitCard(suit: suit)
                    } else {
                        CaseHeader(suit: suit)
                        lawsuitCard(suit: suit)
                    }
                }
                
                plusButton
                    .padding(.top, 30)
            }
            
            Spacer()
            
        }
        .padding()
        .sheet(isPresented: $suitSheet, content: {
            suitSheetView
                .presentationDetents([.height(UIScreen.main.bounds.height*0.15)])
        })
    }
    
    var homeHeader: some View {
        HStack {
            Text("Hi, \(userName)")
                .font(.largeTitle)
                .fontWeight(.bold)
        
            Spacer()
            
            Image("profilePicture")
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .cornerRadius(20)
        }
    }
    
    var plusButton: some View {
        ZStack {
            Button(action: {suitSheet.toggle()}, label: {
                ZStack {
                    Circle()
                        .fill(.accent)
                        
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            })
            .frame(width: 60, height: 60)
        }
    }
    
    var suitSheetView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Neuen Fall hinzufügen")
                .onTapGesture {newSuitSheet.toggle()}
            
            Divider()
            Text("Alle Fälle ansehen")
        }
        .font(.headline)
        .padding()
        .sheet(isPresented: $newSuitSheet, content: {
            newSuitSheetView
                .presentationDetents([.medium])
        })
    }
    
    var newSuitSheetView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    vm.lawsuits.append(lawsuit(lawsuitName: newSuitName, mandateName: newSuitDescription, fileNumbers: []))
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

struct CaseHeader: View {
    let suit: lawsuit
    var body: some View {
        VStack {
            HStack {
                Text(suit.lawsuitName)
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
            }
            Divider()
        }
    }
}

struct lawsuitCard: View {
    
    let suit: lawsuit
    
    var body: some View {
        HStack {
            Spacer()
            Text(suit.lawsuitName)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Divider()
                .padding()
            Spacer()
            VStack {
                Text("\(suit.fileNumbers.count)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Fälle")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .frame(height: 125)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.accent)
        }
        
    }
}

#Preview {
    HomeView()
}
