//
//  LaunchView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 05.12.23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var text: [String] = "JurDat.".map { String($0) }
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var caseVM: CaseViewModel
    @EnvironmentObject var newsVM: NewsViewModel
    @Binding var showLaunchAnimation: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.purple.ignoresSafeArea()
                
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(text.indices) { index in
                            Text(text[index])
                        }
                    }
                    .foregroundStyle(Color.white)
                    .font(.custom("Kadwa-Regular", size: 60))
                }
            }
            .task {
                try? await userVM.loadCurrentUser()
                try? await caseVM.loadNewCases()
                try? await newsVM.loadNews()
            }
            .onAppear {
                // Set show launch animation to false after x seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    showLaunchAnimation = false
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchAnimation: .constant(true))
}
