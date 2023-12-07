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
    @State private var performSearch: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        lawBooksFavorites(lawBookName: "BGB")
                            .onTapGesture {
                                Task {
                                    try? await vm.loadSpecificLawbook(slug: "bgb")
                                }
                            }
                        lawBooksFavorites(lawBookName: "GG")
                            .onTapGesture {
                                Task {
                                    try? await vm.loadSpecificLawbook(slug: "gg")
                                }
                            }
                    }
                    HStack {
                        lawBooksFavorites(lawBookName: "StpO")
                            .onTapGesture {
                                Task {
                                    try? await vm.loadSpecificLawbook(slug: "stpo")
                                }
                            }
                        lawBooksFavorites(lawBookName: "StGB")
                            .onTapGesture {
                                Task {
                                    try? await vm.loadSpecificLawbook(slug: "stgb")
                                }
                            }
                    }
                    
                    if vm.lawBooks.isEmpty {
                        VStack(spacing: 10) {
                            ProgressView()
                            Text("Lade Gesetzbücher...")
                        }
                        .padding()
                    } else {
                        LazyVStack {
                            ForEach(vm.filterLawBooks(searchText: searchText)) { book in
                                singleLawbook(lawBook: book)
                                    .onTapGesture {
                                        Task {
                                            try? await vm.loadSpecificLawbook(slug: book.slug)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
                .navigationTitle("Gesetze")
                .searchable(text: $searchText, prompt: "Suche nach Gesetzen")
                .task {
                    if performSearch {
                        try? await vm.getAllLawbooks()
                        performSearch = false
                    }
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
                .fontWeight(.semibold)
                .padding()
            Divider()
//            PurpleLine()
        }
        .padding(.horizontal)
    }
}

struct singleLawbook: View {
    
    let lawBook: LawBook
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(lawBook.title ?? "")
                .font(.title3)
            .fontWeight(.semibold)
            
            Divider()
        }
        .padding()
    }
}


#Preview {
    LawsOverviewView()
}
