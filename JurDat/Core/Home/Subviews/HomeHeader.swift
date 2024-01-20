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
                if userVM.user != nil {
                    Text("Hi, \(userVM.user?.surname ?? "")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                } else {
                    Text("Hi")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            
                Spacer()
                
                NavigationLink {
                    SettingsView()
                } label: {
                    if userVM.user != nil {
                        Image("profilePicture")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 55, height: 55)
                            .cornerRadius(20)
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(Color.theme.textColor)
                            }
                            .frame(width: 55, height: 55)
                    }
                }
            }
        }
    }
}
