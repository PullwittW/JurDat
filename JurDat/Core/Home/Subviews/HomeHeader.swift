//
//  HomeHeader.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct HomeHeader: View {
    @EnvironmentObject var userVM: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Hi, Wangu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            
                Spacer()
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Image("profilePicture")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .cornerRadius(20)
                }
            }
        }
    }
}
