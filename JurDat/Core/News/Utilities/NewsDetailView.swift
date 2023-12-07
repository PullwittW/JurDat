//
//  NewsDetailView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 05.12.23.
//

import SwiftUI

struct NewsDetailView: View {
    let news: News
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                userView
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
                    } label: {
                        Image(systemName: "heart")
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
                        }
                        if let beratungszustand = news.beratungsstand {
                            Text("Beratungsstand: " + beratungszustand)
                        }
                    }
                    .font(.title3)
                    
                    Spacer()
                }
                
                Divider()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(news.abstract ?? "Kein Inhalt verfügbar")
                }
            }
            .padding()
        }
    }
}
