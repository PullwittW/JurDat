//
//  FavoriteCaseCard.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.01.24.
//

import SwiftUI

struct FavoriteCaseCard: View {
    
    let slug: String
    
    var body: some View {
        HStack {
            Text(slug)
                .padding()
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .scaledToFit()
                .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .foregroundStyle(Color.white)
        .bold()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.purple)
                .frame(height: 40)
        }
    }
}

#Preview {
    FavoriteCaseCard(slug: "abcdefghijklmnop")
}
