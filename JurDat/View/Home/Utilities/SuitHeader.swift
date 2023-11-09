//
//  SuitHeader.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import Foundation
import SwiftUI

struct SuitHeader: View {
    var body: some View {
        VStack {
            HStack {
                Text("Deine Fälle")
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
            }
            Divider()
        }
    }
}
