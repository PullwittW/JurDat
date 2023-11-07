//
//  LawsOverviewView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import SwiftUI

struct LawsOverviewView: View {
    
    @StateObject var vm = LawBookViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    lawBooksFavorites(lawBookName: "BGB")
                    lawBooksFavorites(lawBookName: "GG")
                }
                HStack {
                    lawBooksFavorites(lawBookName: "StpO")
                    lawBooksFavorites(lawBookName: "StGB")
                }
                
                if vm.lawBooks.isEmpty {
                    VStack {
                        ProgressView()
                    }
                    .padding()
                } else {
                    ScrollView {
                        ForEach(vm.filterLawBooks(searchText: searchText)) { book in
                            lawBooks(lawBook: book)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .navigationTitle("Gesetze")
            .searchable(text: $searchText, prompt: "Suche nach Gesetzen")
            .onAppear {
//                vm.loadLawBooks()
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    print(vm.lawBooks)
                }
            }
        }
    }
}

struct lawBooksFavorites: View {
    var lawBookName: String
    var body: some View {
        VStack {
            Text(lawBookName)
                .font(.title3)
                .padding()
            Divider()
        }
        .padding(.horizontal)
    }
}

struct lawBooks: View {
    
    let lawBook: LawBook
    
    var body: some View {
        VStack {
            Text(lawBook.title ?? "")
                .font(.title2)
            .fontWeight(.bold)
            
            Divider()
        }
        .padding()
    }
}


#Preview {
    LawsOverviewView()
}
