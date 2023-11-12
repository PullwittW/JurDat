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
    
    var body: some Scene {
        WindowGroup {
//            LogInView()
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

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
