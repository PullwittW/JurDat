//
//  LawsuitCardView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 24.11.23.
//

import SwiftUI

struct LawsuitDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: SettingsViewModel
    let lawsuit: Lawsuit
    @State private var deleteSheet: Bool = false
    
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
                            }
                            .foregroundStyle(Color("TextColor"))
                            .font(.callout)
                            .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                    Divider()
                    
                    Spacer()
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
                                .bold()
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {deleteSheet.toggle()}, label: {
                            Image(systemName: "trash")
                                .resizable()
                                .bold()
                        })
                    }
                }
                .interactiveDismissDisabled()
                .actionSheet(isPresented: $deleteSheet, content: {
                    ActionSheet(title: Text("Löschen bestätigen"), message: Text("Diese Aktion ist unwiderruflich"), buttons: [ .destructive(Text("Löschen"), action: {
                        userVM.removeLawsuit(lawsuit: lawsuit)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                            Task {
//                                try await userVM.loadCurrentUser()
//                            }
//                        }
                    }), .cancel()])
                })
            }
        }
    }
}

#Preview {
    LawsuitDetailView(lawsuit: Lawsuit(lawsuitName: "Test",
                                     lawsuitDescription: "Dies ist eine Testkarte",
                                     fileNumbers: []))
}
