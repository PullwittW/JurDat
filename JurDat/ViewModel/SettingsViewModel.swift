//
//  SettingsViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.singOut()
    }
}
