//
//  FavoriteNewsCard.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.01.24.
//

import SwiftUI

struct FavoriteNewsCard: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding()
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .scaledToFit()
                .padding()
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(Color.white)
        .bold()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.primaryPurple)
        }
    }
}

#Preview {
    FavoriteNewsCard(title: "Entwurf eines Gesetzes zur Modernisierung des Postrechts (Postrechtsmodernisierungsgesetz - PostModG")
}
