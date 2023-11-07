//
//  JurDatApp.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

@main
struct JurDatApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .preferredColorScheme(.light)
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                SearchPage()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
//                LawsOverviewView()
//                    .tabItem {
//                        Image("lawBookIcon")
//                    }
            }
            
        }
    }
}
