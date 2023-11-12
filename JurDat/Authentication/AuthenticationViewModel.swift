//
//  AuthenticationViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import Firebase

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let token = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: token)
    }
}
