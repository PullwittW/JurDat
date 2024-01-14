//
//  NewsView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.11.23.
//

import SwiftUI

struct NewsView: View {
    
    @EnvironmentObject var newsVM: NewsViewModel
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
                        LazyVStack(alignment: .leading) {
                            ForEach(newsVM.filterNews(searchText: searchText)) { news in
                                SingleNewsView(news: news)
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle("News")
            .searchable(text: $searchText, prompt: "Suche nach Vorgängen")
            .refreshable {
                try? await newsVM.loadNews()
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewsView()
    }
}
