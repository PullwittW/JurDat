//
//  HomeHeader.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 09.11.23.
//

import SwiftUI

struct HomeHeader: View {
    @State var userName: String
    var body: some View {
        HStack {
            Text("Hi, \(userName)")
                .font(.largeTitle)
                .fontWeight(.bold)
        
            Spacer()
            
            Image("profilePicture")
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .cornerRadius(20)
        }
    }
}
