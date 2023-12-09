//
//  LawsOverviewView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import SwiftUI

struct LawsOverviewView: View {
    
    @EnvironmentObject var bookVM: LawBookViewModel
    @State private var showCaseDetailView: Bool = false
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
                                    try? await bookVM.loadSpecificLawbook(bookId: "1280")
                                }
                                
                            }
                        lawBooksFavorites(lawBookName: "GG")
                            .onTapGesture {
                                Task {
                                    try? await bookVM.loadSpecificLawbook(bookId: "2215")
                                }
                            }
                    }
                    HStack {
                        lawBooksFavorites(lawBookName: "StpO")
                            .onTapGesture {
                                Task {
                                    try? await bookVM.loadSpecificLawbook(bookId: "2012")
                                }
                            }
                        lawBooksFavorites(lawBookName: "StGB")
                            .onTapGesture {
                                Task {
                                    try? await bookVM.loadSpecificLawbook(bookId: "2009")
                                }
                            }
                    }
                    
                    if bookVM.lawBooks.isEmpty {
                        VStack(spacing: 10) {
                            ProgressView()
                            Text("Lade Gesetzbücher...")
                        }
                        .padding()
                    } else {
                        LazyVStack {
                            ForEach(bookVM.filterLawBooks(searchText: searchText)) { book in
                                singleLawbook(lawBook: book)
                                    .onTapGesture {
                                        Task {
                                            try? await bookVM.loadSpecificLawbook(bookId: String(book.id))
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
                        try? await bookVM.getAllLawbooks()
                        performSearch = false
                    }
                }
            }
        }
    }
}

struct lawBooksFavorites: View {
    @StateObject var bookVM = LawBookViewModel()
    var lawBookName: String
    var body: some View {
        VStack {
            Text(lawBookName)
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
            Divider()
        }
        .padding(.horizontal)
        .environmentObject(bookVM)
    }
}

struct singleLawbook: View {
    
    let lawBook: LawBook
    @StateObject var bookVM = LawBookViewModel()
    @State private var showCaseDetailView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(lawBook.title ?? "")
                .font(.title3)
            .fontWeight(.semibold)
            
            Divider()
        }
        .padding()
        .onTapGesture {
            showCaseDetailView.toggle()
        }
        .sheet(isPresented: $showCaseDetailView, content: {
            
        })
        .environmentObject(bookVM)
    }
}


#Preview {
    LawsOverviewView()
}
