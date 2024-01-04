//
//  PurpleLine.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.11.23.
//

import SwiftUI

struct PurpleLine: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .scaledToFit()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.theme.textColor)
            }
            .frame(width: 55, height: 55)
    }
}

#Preview {
    PurpleLine()
}
