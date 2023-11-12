//
//  SettingsViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
        
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileIsDirectory)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "test4@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "password1"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.singOut()
    }
    
    func deleteUser() async throws {
        try await AuthenticationManager.shared.deleteUser()
    }
}
