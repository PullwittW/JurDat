//
//  SuitSheetView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct SuitSheetView: View {
    @Binding var newSuitSheet: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Neuen Fall hinzufügen")
                .onTapGesture {newSuitSheet.toggle()}
            
            Divider()
            Text("Alle Fälle ansehen")
        }
        .font(.headline)
        .padding()
        
    }
}
