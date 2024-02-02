//
//  HomeHeader.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct HomeHeader: View {
    @EnvironmentObject var userVM: SettingsViewModel
    @State private var showWelcommingText: Bool = true
    
    var body: some View {
        NavigationStack {
            HStack {
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color.theme.purple)
                    .bold()
                    .frame(width: 25, height: 25)
            
                Spacer()
                
                NavigationLink {
                    SettingsView()
                } label: { 
                    if let urlString = userVM.user?.profileImagePath, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 45, height: 45)
                                .cornerRadius(20)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 45, height: 45)
                        }
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .padding(8)
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                    }
                }
            }
        }
    }
}
