//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = CaseViewModel()
    @State var userName = "Wangu"
    
    var body: some View {
        VStack {
            HStack {
                Text("Hi, \(userName)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            
                Spacer()
                Image("profilePicture")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(20)
            }
            
            CaseHeader()
            
        }
        .padding()
    }
}

struct CaseHeader: View {
    
    let headerCaseName: String = "XYZ/23 Klaus"
    
    var body: some View {
        VStack {
            HStack {
                Text(headerCaseName)
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
            }
            Divider()
        }
    }
}

#Preview {
    HomeView()
}
