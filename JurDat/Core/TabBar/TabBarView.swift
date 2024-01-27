//
//  TabBarView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.01.24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            HomeView()
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            SearchPage()
                .tabBarItem(tab: .cases, selection: $tabSelection)
            
            LawsOverviewView()
                .tabBarItem(tab: .books, selection: $tabSelection)
            
            NewsView()
                .tabBarItem(tab: .news, selection: $tabSelection)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
