//
//  PurpleLine.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.11.23.
//

import SwiftUI

struct PurpleLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(Color.accentColor.opacity(0.4))
    }
}

#Preview {
    PurpleLine()
}
