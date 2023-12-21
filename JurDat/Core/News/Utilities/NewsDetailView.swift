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
                                print("News is Favorite")
                            } else {
                                userVM.removeNews(news: news)
                                newsIsFavorite = false
                                print("News is no Favorite")
                            }
                        } label: {
                            Image(systemName: newsIsFavorite ? "heart" : "heart.fill")
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
        }
    }
    
    var userView: some View {
        ScrollView {
            VStack {
                Text(news.titel)
                    .font(.title2)
                    .bold()
                
                HStack(spacing: 10) {
                    Rectangle()
                        .foregroundStyle(Color.accentColor)
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
                    Text(news.abstract?.html2String ?? "Kein Inhalt verfügbar")
                        .lineSpacing(2.0)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                }
                .padding(.vertical)
            }
            .padding()
            .interactiveDismissDisabled()
        }
    }
}
