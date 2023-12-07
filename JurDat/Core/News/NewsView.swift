//
//  NewsView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.11.23.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject private var newsVM = NewsViewModel()
    @State private var performSearch: Bool = true
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if newsVM.news.isEmpty {
                    VStack(spacing: 10) {
                        ProgressView()
                        Text("Lade News...")
                    }
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(newsVM.filterNews(searchText: searchText)) { news in
                                SingleNewsView(news: news)
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle("News")
            .task {
                if performSearch {
                    try? await newsVM.loadNews()
                    performSearch = false
                }
            }
            .refreshable {
                try? await newsVM.loadNews()
            }
            .searchable(text: $searchText, prompt: "Suche nach Vorgängen")
        }
    }
}

#Preview {
    NavigationStack {
        NewsView()
    }
}
