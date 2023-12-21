//
//  LaunchView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 05.12.23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var text1: [String] = ["u","r"]
    @State private var text2: [String] = ["a","t","."]
    @State private var emptyString1: [String] = ["J"]
    @State private var emptyString2: [String] = ["D"]
    @EnvironmentObject var userVM: SettingsViewModel
    @EnvironmentObject var caseVM: CaseViewModel
    @EnvironmentObject var newsVM: NewsViewModel
    @Binding var showLaunchAnimation: Bool
    
    private func appendToString1() {
        for index in text1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                emptyString1.append(index)
            }
        }
    }
    
    private func appendToString2() {
        for index in text2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                emptyString2.append(index)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.purple.ignoresSafeArea()
                
                ZStack {
                    withAnimation(.easeIn(duration: 0.5)) {
                        HStack(spacing: 0) {
                            ForEach(emptyString1, id: \.self) { item in
                                Text(item)
                            }
                            ForEach(emptyString2, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .foregroundStyle(Color.white)
                        .font(.custom("Kadwa-Regular", size: 63))
                    }
                }
            }
            .task {
                try? await userVM.loadCurrentUser()
                try? await caseVM.loadNewCases()
                try? await newsVM.loadNews()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    appendToString1()
                    appendToString2()
                }
                // Set show launch animation to false after x seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showLaunchAnimation = false
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchAnimation: .constant(true))
}
