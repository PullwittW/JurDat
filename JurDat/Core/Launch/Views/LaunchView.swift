//
//  LaunchView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 05.12.23.
//

import SwiftUI

struct LaunchView: View {
    
    @StateObject private var caseVM = CaseViewModel()
    @StateObject private var userVM = UserViewModel()
    @StateObject private var newsVM = NewsViewModel()
    @State private var text: [String] = "JurDat.".map { String($0) }
    @Binding var showLaunchAnimation: Bool
    
    var body: some View {
        ZStack {
            Color.theme.purple.ignoresSafeArea()
            
            ZStack {
                HStack(spacing: 0) {
                    ForEach(text.indices) { index in
                        Text(text[index])
                    }
                }
                .foregroundStyle(Color.theme.textColor)
                .font(.custom("Kadwa-Regular", size: 60))
            }
        }
        .onAppear {
            // Set show launch animation to false after x seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                showLaunchAnimation = false
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchAnimation: .constant(true))
}
