//
//  JurDatApp.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import Firebase

@main
struct JurDatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var showLaunchAnimation: Bool = true
    @StateObject private var caseVM = CaseViewModel()
    @StateObject private var userVM = UserViewModel()
    @StateObject private var newsVM = NewsViewModel()
    
    var body: some Scene {
        WindowGroup {
//            LogInView()
            ZStack {
                TabView {
                    
                    HomeView()
                        .preferredColorScheme(.light)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    SearchPage()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Suchen")
                        }
                    
                    LawsOverviewView()
                        .tabItem {
                            Image("lawBookIcon2")
                                .renderingMode(.template)
                            Text("Gesetze")
                        }
                    
                    NewsView()
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text("News")
                        }
                }
                // Show the animation on launch
                if showLaunchAnimation {
                    LaunchView(showLaunchAnimation: $showLaunchAnimation)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
