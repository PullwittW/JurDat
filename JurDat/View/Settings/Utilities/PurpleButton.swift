//
//  PurpleButton.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import SwiftUI

struct PurpleButton: View {
    var buttonName: String
    var body: some View {
        Text(buttonName)
            .font(.headline)
            .foregroundStyle(.white)
            .bold()
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.accent)
            .cornerRadius(10)
    }
}

