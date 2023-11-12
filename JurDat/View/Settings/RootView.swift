//
//  SignInView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                LogInView()
            }
        })
    }
}

#Preview {
    RootView()
}
