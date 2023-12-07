//
//  LawsuitCardView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 24.11.23.
//

import SwiftUI

struct LawsuitDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    let lawsuit: Lawsuit
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(lawsuit.lawsuitName)
                        .font(.title2)
                        .bold()
                    if lawsuit.lawsuitDescription != nil && lawsuit.lawsuitDescription != "" {
                        HStack(spacing: 10) {
                                Rectangle()
                                    .foregroundStyle(Color.accentColor)
                                    .frame(width: 3)
                            VStack(alignment: .leading) {
                                Text(lawsuit.lawsuitDescription ?? "")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                    }
    //                PurpleLine()
                    Divider()
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {dismiss()}, label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .fontWeight(.bold)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .fontWeight(.bold)
                        })
                    }
                }
                .interactiveDismissDisabled()
            }
        }
    }
}

#Preview {
    LawsuitDetailView(lawsuit: Lawsuit(lawsuitName: "Test",
                                     lawsuitDescription: "Dies ist eine Testkarte",
                                     fileNumbers: []))
}
