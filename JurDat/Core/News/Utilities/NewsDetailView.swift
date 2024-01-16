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
    @State private var showAddToSuitSheet: Bool = false
    @State private var newsContent: String = ""
    
    let news: News
    
    private func newsIsSelected(newsTitel: String) -> Bool {
        userVM.user?.favoriteNews?.contains(newsTitel) == true
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if userVM.user != nil {
                        userView
                            .padding()
                    } else {
                        VStack {
                            Text("Um Inhalte zu sehen, logge dich ein.")
                        }
                    }
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
                    .disabled(userVM.user != nil ? false : true)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {showAddToSuitSheet.toggle()}, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .fontWeight(.bold)
                    })
                    .disabled(userVM.user != nil ? false : true)
                }
            }
            .sheet(isPresented: $showAddToSuitSheet) {
                List {
                    Section {
                        ForEach(userVM.user?.lawsuits ?? []) { suit in
//                        ForEach(userVM.userLawsuits) { suit in
                            Button {
//                                userVM.addNewsToLawsuit(lawsuit: suit, newsItem: news)
                                print("\(suit.lawsuitName) tapped")
                            } label: {
                                Text(suit.lawsuitName)
                            }
                        }
                    } header: {
                        Text("Zu Sammlung hinzufügen...")
                    }
                }
                .presentationDetents([.medium])
            }
        }
        .interactiveDismissDisabled()
    }
    
    var userView: some View {
        VStack {
            Text(news.titel)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
            
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
            
            Divider()
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(newsContent)
                    .lineSpacing(2.0)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
            }
        }
        .interactiveDismissDisabled()
        .onAppear {
            newsContent = news.abstract?.html2String ?? "Kein Inhalt verfügbar"
        }
    }
}
