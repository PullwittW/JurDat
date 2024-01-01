//
//  NewsDetailView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 05.12.23.
//

import SwiftUI

struct NewsDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: SettingsViewModel
    @State private var newsIsFavorite: Bool = false
    
    let news: News
    
    private func newsIsSelected(newsTitel: String) -> Bool {
        userVM.user?.favoriteNews?.contains(newsTitel) == true
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    userView
                }
            }
            .onAppear {
                Task {
                    try? await userVM.loadCurrentUser()
                }
                if newsIsSelected(newsTitel: news.titel) {
                    newsIsFavorite = true
                } else {
                    newsIsFavorite = false
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {dismiss()}, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .fontWeight(.bold)
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if !newsIsFavorite {
                            userVM.addNews(news: news)
                            newsIsFavorite = true
                            print("News is favorite")
                        } else {
                            userVM.removeNews(news: news)
                            newsIsFavorite = false
                            print("News is no favorite")
                        }
                    } label: {
                        Image(systemName: newsIsFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .fontWeight(.bold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .fontWeight(.bold)
                    })
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    var userView: some View {
        VStack {
            Text(news.titel)
                .font(.title2)
                .bold()
            
            HStack(spacing: 10) {
                Rectangle()
                    .foregroundStyle(Color.theme.purple)
                    .frame(width: 3)
                VStack(alignment: .leading) {
                    ForEach(news.initiative ?? [], id: \.self) { news in
                        Text(news)
                            .foregroundStyle(Color("TextColor"))
                    }
                    if let beratungszustand = news.beratungsstand {
                        Text("Beratungsstand: " + beratungszustand)
                            .foregroundStyle(Color("TextColor"))
                    }
                }
                .font(.callout)
                .bold()
                
                Spacer()
            }
            .padding(.vertical)
            
            Divider()
            
            Spacer()
            
            VStack(alignment: .leading) {
                if let abstract = news.abstract {
                    Text(abstract)
                        .lineSpacing(2.0)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                }
            }
            .padding(.vertical)
        }
        .padding()
        .interactiveDismissDisabled()
    }
}
