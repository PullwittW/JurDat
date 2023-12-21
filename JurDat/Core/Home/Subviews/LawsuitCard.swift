//
//  LawsuitCard.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct LawsuitCard: View {
    
    let suit: Lawsuit
    let color: String
    @State private var showLawsuitDetailView: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Text(suit.lawsuitName)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            VStack {
                Text("\(suit.fileNumbers.count)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Fälle")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: 100)
            .frame(minWidth: 100)
        }
        .foregroundColor(.white)
        .frame(height: 125)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.theme.purple)
        }
        .onTapGesture {
            showLawsuitDetailView.toggle()
        }
        .sheet(isPresented: $showLawsuitDetailView, content: {
            LawsuitDetailView(lawsuit: suit)
        })
    }
}
