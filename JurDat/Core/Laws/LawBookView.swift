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
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
                .navigationTitle("Gesetze")
                .searchable(text: $searchText, prompt: "Suche nach Gesetzen")
            }
        }
    }
}

struct lawBooksFavorites: View {
    @EnvironmentObject var bookVM: LawBookViewModel
    var lawBookName: String
    var lawBookID: String
    @State private var showBookDetailView: Bool = false
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
        .onTapGesture {
            showBookDetailView.toggle()
        }
        .sheet(isPresented: $showBookDetailView, content: {
            LawBookView(lawBookTitel: "", lawBookID: lawBookID)
        })
    }
}

struct singleLawbook: View {
    
    let lawBook: LawBook
    @EnvironmentObject var bookVM: LawBookViewModel
    @State private var showBookDetailView: Bool = false
    
    var body: some View {
        NavigationLink {
            LawBookView(lawBookTitel: lawBook.title ?? "", lawBookID: String(lawBook.id))
        } label: {
            VStack(alignment: .leading) {
                Text(lawBook.title ?? "")
                    .foregroundStyle(Color.black)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Divider()
            }
            .padding()
        }

//        VStack(alignment: .leading) {
//            Text(lawBook.title ?? "")
//                .font(.title3)
//            .fontWeight(.semibold)
//            
//            Divider()
//        }
//        .padding()
//        .onTapGesture {
//            showBookDetailView.toggle()
//        }
//        .sheet(isPresented: $showBookDetailView, content: {
//            
//        })
    }
}


#Preview {
    LawsOverviewView()
}
