//
//  LawsuitCard.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct LawsuitCard: View {
    
    let lawsuit: Lawsuit
    @State private var showLawsuitDetailView: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Text(lawsuit.lawsuitName)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            VStack {
                Text("\(lawsuit.fileNumbers.count)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(lawsuit.fileNumbers.count == 1 ? "Fall" : "Fälle")
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
                .fill(Color.theme.primaryPurple)
        }
        .onTapGesture {
            showLawsuitDetailView.toggle()
        }
        .sheet(isPresented: $showLawsuitDetailView, content: {
            LawsuitDetailView(lawsuit: lawsuit)
        })
    }
}
