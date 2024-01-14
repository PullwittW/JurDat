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
    var user = SettingsViewModel()
    var caseItem = CaseViewModel()
    var news = NewsViewModel()
    var laws = LawBookViewModel()
    var email = SignInEmailViewModel()
    var auth = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabView {
                    HomeView()
                        .preferredColorScheme(.light)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .environmentObject(email)
                        .environmentObject(auth)
                    
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
            .environmentObject(user)
            .environmentObject(caseItem)
            .environmentObject(news)
            .environmentObject(laws)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
