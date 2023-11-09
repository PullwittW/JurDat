//
//  LawsuitCard.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct LawsuitCard: View {
    
    let suit: lawsuit
    
    var body: some View {
        HStack {
            Spacer()
            Text(suit.lawsuitName)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Divider()
                .padding()
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
            Spacer()
        }
        .foregroundColor(.white)
        .frame(height: 125)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.accent)
        }
    }
}
