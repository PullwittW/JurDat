//
//  SingleNewsView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 04.12.23.
//

import SwiftUI

struct SingleNewsView: View {
    
    @StateObject private var newsVM = NewsViewModel()
    @State private var showNewsDetailView: Bool = false
    let news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(news.titel)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
            
            
            Text(newsVM.formattedDate(dateString: news.datum ?? ""))
                .fontWeight(.semibold)
            
            ForEach(news.initiative ?? [], id: \.self) { type in
                Text(type)
            }
            if let beratungszustand = news.beratungsstand {
                Text("Beratungsstand: " + beratungszustand)
            }
        }
        .padding()
        .onTapGesture {
            showNewsDetailView.toggle()
            print(news.id)
        }
        .sheet(isPresented: $showNewsDetailView, content: {
            NewsDetailView(news: news)
        })
    }
}
