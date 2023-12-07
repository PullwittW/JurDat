//
//  PlusButton.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct PlusButton: View {
    @Binding var suitSheet: Bool
    var body: some View {
        ZStack {
            Button(action: {suitSheet.toggle()}, label: {
                ZStack {
                    Circle()
                        .fill(.accent)
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            })
            .frame(width: 60, height: 60)
        }
    }
}
